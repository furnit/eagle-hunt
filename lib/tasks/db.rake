namespace :db do
  BACKUP_FILE_NAME = "database.sql"
  REPO_DIR = Rails.root.join('db/backup')
  
  desc "Backup database and commit into git repo"
  task backup: :environment do    
    Rails.logger.info "[db:backup] starting at #{Time.now}".yellow
    
    unless Dir.exist?(REPO_DIR)
      system("git clone #{ENV["DATABASE_BACKUP_REPO_#{Rails.env.upcase}"]} #{REPO_DIR}") or alert_admins
      Rails.logger.info "[db:backup] repo cloned into #{REPO_DIR}".blue
    end
    
    opts = '--extended-insert --skip-dump-date --lock-tables=false'
    
    mysql_cmd("mysqldump %{credentials} #{opts} %{database} > #{REPO_DIR}/#{BACKUP_FILE_NAME}") or alert_admins
    Rails.logger.info "[db:backup] mysqldump: #{REPO_DIR}/#{BACKUP_FILE_NAME}".blue
    
    system("cd #{REPO_DIR} && git add -A && (git commit -m 'backup: #{Time.now}' || true) && git push origin master") or alert_admins
    
    Rails.logger.info "[db:backup] repo push".blue
    Rails.logger.info "[db:backup] finishes at #{Time.now}".yellow
  end

  desc "Restore database from latest dump"
  task restore: :environment do
    mysql_cmd("mysql %{credentials} -D %{database} < #{REPO_DIR}/#{BACKUP_FILE_NAME}") or alert_admins
    Rails.logger.info "[db:restore] mysql restore".blue
  end

  def mysql_cmd(cmd)
    config = Rails.configuration.database_configuration[Rails.env]

    # create this file to avoid warning "Using a password on the command line interface can be insecure"
    file = Tempfile.new('temp-config')
    out = nil;
    begin
      file.write <<~CNF
        [client]
        user = #{config['username']}
        password = #{config['password']}
        host = #{config['host'] || 'localhost'}
        port = #{config['port'] || '3306'}
      CNF
      file.close

      out = system("#{cmd % {credentials: "--defaults-file=#{file.path}", database: config['database']}}")
    ensure
      file.delete
    end
    return out;
  end

  def  alert_admins
    require Rails.root.join('lib/sms/bootstrap')
    
    message = <<~sms
    خطا در پشتیبان‌گیری از پایگاه‌داده!
    
    مبل ویرا
    #{AppConfig.domain}
    sms
    Rails.logger.error "[db:backup/restore] failed to finish the op!".red
    
    unless SMS.send message, to: Admin::UserType.where(symbol: :ADMIN).first.users.select(:phone_number).collect {|u| u.phone_number }.join(',')
      Rails.logger.error "[db:backup/restore] failed to alert the admins by sms!".red
    end
    
    exit(1)
  end

end

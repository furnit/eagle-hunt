require 'fileutils'
require 'optparse'

namespace :rename do
  desc "Renames a scaffold in project"
  task scaffold: :environment do

    $available_args = {
      from: "The current scaffold name.",
      to: "The target scaffold name.",
      effectless: "Don't do anything real! just simulate.",
      backup: "Backup the changed files.",
      restore: "Restore the changes.",
      help: "Display this help message."
    }

    def tab
      " " * 2
    end

    def help_message
      puts "Usage: rake rename:scaffold -- [OPTIONS]"
      $available_args.each do |arg, m|
        puts "#{tab}#{arg.to_s.yellow}: #{m}"
      end
    end

    def p *strs
      puts strs.map(&:to_s).join(" ")
    end

    def if_demo_text
      return if not $args[:effectless] or $args[:demo_text_displayed]
      p "THIS IS A DEMO:".red, "anything you see here DIDN'T applied!".yellow
      $args[:demo_text_displayed] = true
    end

    def if_apply &block
      block.call() if not $args[:effectless]
    end

    def if_demo &block
      if_demo_text
      block.call() if $args[:effectless]
    end

    def str_replace file, old_text, new_text, regex: false
      file_bk = "#{file}.bk-scaffold-rename";
      if_apply do
        # backup file
        FileUtils.cp(file, file_bk)
        # replace string
        IO.write(file, File.open(file) { |f| f.read.gsub(old_text, new_text) } )
        # check if file's content changed?
        if not FileUtils.compare_file(file, file_bk)
          $args[:proccessed] ||= { }
          p "@ #{file}".green if not $args[:proccessed][file]
          $args[:proccessed][file] = true
        end
        # remove the backup file if not mentioned
        FileUtils.rm file_bk if not $args[:backup]
      end
      if_demo do
        replaces = []
        File.foreach(file).with_index do |line, index|
          next if regex and line !~ /#{old_text}/
          next if not regex and not line.include? old_text
          replaces << ["[l:#{index}]", line.gsub(/(.*)([^\s"',\.]*)#{old_text}([^\s"',\.]*)(.*)/i, '[...] \2' + "#{old_text.yellow}" + '\3 [...]').strip, "->", line.gsub(/(.*)([^\s"',\.]*)#{old_text}([^\s"',\.]*)(.*)/, '[...] \2' + "#{new_text.green}" + '\3 [...]').strip]
        end
        if not replaces.empty?
          p "backup:".yellow, "`#{file}`", "-> `#{file_bk}`"
          p "seaching & replace:".yellow, "in `#{file}`"
          replaces.each { |r| p tab, *r }
          p
        end
      end
    end

    def move_file file, old_substitute, new_substitute
      if_apply do
        newfile = file.gsub(old_substitute, new_substitute)
        next if not File.exists?(file) or newfile == file
        FileUtils.mkdir_p(File.dirname(newfile)) unless File.exists?(File.dirname(newfile))
        FileUtils.mv file, newfile
        p "rename: ".yellow, file.gsub(old_substitute, old_substitute.yellow), "->", file.gsub(old_substitute, new_substitute.green)
      end
      if_demo do
        $args[:proccessed] ||= { }
        $args[:proccessed][:rename] ||= { } 
        p "rename: ".yellow, file.gsub(old_substitute, old_substitute.yellow), "->", file.gsub(old_substitute, new_substitute.green) if not $args[:proccessed][:rename][file]
        $args[:proccessed][:rename][file] = 1 
      end
    end

    # parse the agrs
    $args = Hash[ ARGV.flat_map{|s| s.scan(/--?([^=\s]+)(?:=(\S+))?/) } ].map { |k, v| { "#{k.gsub(/^[-]+/, "").to_sym}": v.nil? ? true : v }}.reduce({}, :merge)

    $args.delete :""
    $args.delete :"rename:scaffold"

    $args.each do |arg, _|
      if not $available_args.keys.include? arg.to_sym
        puts "[ERROR] undefined argument `#{arg}`".red
        help_message
        exit(1)
      end
      if arg == :help
        help_message 
        exit
      end
    end

    # check the necessary
    raise Exception.new("Args `--to` or `--from` didn't provided!") if not $args.select { |i| [:from, :to].include? i }.all?

    if_demo_text

    [:from, :to].each do |arg|
      if $args[arg].singularize != $args[arg]
        p "[WARNING] the `--#{arg}` is NOT singular, it will be convert to singular (i.e: `#{$args[arg].singularize}`).".yellow
        $args[arg] = $args[arg].singularize
      end
    end

    to = $args[:to]
    from = $args[:from]

    if $args[:restore]
      p "RESTORING...".yellow
      to, from = from, to
    end

    # replace the origin name
    folders = [ :app, :db, :config ]
    pattern = "/**/*{rb,yml,css,js,coffee}"
    folders.each do |folder|
      p "\n#{"-"*80}\n"
      p "#{folder}/*" 
      p

      files = Dir.glob "#{folder}#{pattern}"
      # search & replace class names
      files.each do |f|
        str_replace f, from.pluralize, to.pluralize
        str_replace f, from.singularize, to.singularize
        str_replace f, from.tableize, to.tableize
        str_replace f, from.tableize.singularize, to.tableize.singularize
        str_replace f, from.tableize.gsub("/", "_"), to.tableize.gsub("/", "_")
        str_replace f, from.tableize.gsub("/", "_").singularize, to.tableize.gsub("/", "_").singularize
      end

      files.each do |f|
        if f =~ /.*#{from.tableize.singularize}/
          move_file f, from.tableize.pluralize, to.tableize.pluralize
          move_file f, from.tableize.singularize, to.tableize.singularize
        end
      end
    end
    
    p "\n#{"-"*80}\n"
    p "NOTICES: ".yellow
    [
      "you need to modify the `#{"config/routes.rb".yellow}` by your self.",
      "you may need to reset you database schema; use: `#{"rails db:drop && rails db:create && rails db:schema:load && rails db:seed".yellow}`"
    ].each.with_index do |n, index|
      p "#{tab}[#{index + 1}] #{n}"
    end
    p "#{"-"*80}\n"
  end

end

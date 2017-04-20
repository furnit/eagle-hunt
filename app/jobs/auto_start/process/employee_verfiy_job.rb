class AutoStart::Process::EmployeeVerfiyJob < PeriodicJob
  queue_as :urgent
  
  def schedule
    # tick at 04:00 am
    # time Date.tomorrow.noon.change hour: 4
  end

  def perform(*args)
    employee_types = AppConfig.process.employee.verify.map { |i| i.upcase.to_sym }
    Admin::UserType.where(symbol: employee_types).each do |user_type|
      self.send("process_#{user_type.symbol.to_s.downcase}_employee", user_type.users)  
    end
  end

  def include_admins
    Admin::UserType.where(symbol: :ADMIN).first.users
  end
  
  def process_fani_employee employees
    employees += include_admins
    ap [:fani, employees]
  end
  def process_najar_employee employees
    employees += include_admins
    ap [:najar, employees]
  end
  def process_nagash_employee employees
    employees += include_admins
    ap [:nagash, employees]
  end
  def process_kanaf_employee employees
    employees += include_admins
    ap [:kanaf, employees]
  end
end

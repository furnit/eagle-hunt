[
  'lib/sms/bootstrap',
  'lib/two_step_auth'
]
.each do |file|
  require Rails.root.join(file)
end

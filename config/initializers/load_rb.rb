[
  'lib/exceptions',
  'lib/sms/bootstrap',
  'lib/two_step_auth',
  'lib/compute_price',
  'lib/utilities',
  'lib/curl',
  'lib/transaction',
]
.each do |file|
  require Rails.root.join(file)
end

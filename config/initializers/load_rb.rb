[
  'lib/sms/bootstrap',
  'lib/two_step_auth',
  'lib/compute_price',
  'lib/utilities',
]
.each do |file|
  require Rails.root.join(file)
end

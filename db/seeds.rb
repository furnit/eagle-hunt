# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_types_list = [
  ['ادمین', 'ADMIN', 'ادمین سایت، دسترسی کامل به کل سایت' ,1001],
  ['مشتری', 'CLIENT','مشتری سایت که دسترسی عمومی به محتویات سایت دارد',1],
  ['روکوب', 'ROKOB','موجودیت روکوب کار، امکان دسترسی به ارزیابی اطلاعات روکوبی مبلمان‌ها ',2],
  ['خیاط', 'KHAYAT','موجودیت خیاط کار، امکان دسترسی به ارزیابی اطلاعات خیاطی مبلمان‌ها و مشخصات پارچه‌ ',2],
  ['نجار', 'NAJAR','موجودیت نجار، امکان دسترسی به ارزیابی اطلاعات نجاری و کنده‌کاری مبلمان‌ها ',2],
  ['نقاش', 'NAGASH','موجودیت نقاش کار، امکان دسترسی به ارزیابی اطلاعات نقاشی مبلمان‌ها ',2],
  ['کارشناس گرافیک', 'GRAPHIC','بررسی گرافیکی و سلیقه‌ای محصولات و ثبت پیشنهادات مرتبط',2],
  ['بازاریاب', 'MARKETER','بازاریاب‌ محصولات',2],
  ['بازرس', 'PR','بازرسی کیفی فعالیت‌های بازاریاب‌ها، روابط عمومی مشتری‌ها',3],
  ['بازارسنج', 'MARKLINE','مسئول بروز رسانی قیمت‌های کالاها و لوازم پیش‌نیاز محصولات خدماتی',2]
]

user_types_list.each do |name, symbol, comment, auth_level|
  Admin::UserType.create(name: name, symbol: symbol, comment: comment, auth_level: auth_level)
end

users_list = [
  ['09120686119','04918821',1],
]
users_list.each do |phone_number, password, user_type_id|
  User.create!(phone_number: phone_number, password: password, admin_user_type_id: user_type_id)
end

profiles_list = [
  ['داریوش', 'حسن‌پور', 'فولادشهر', 1]
]
profiles_list.each do |first_name, last_name, address, user_id|
  Profile.create!(first_name: first_name, last_name: last_name, address: address, user_id: user_id)
end

states_list = [
  'آذربایجان شرقی', 'آذربایجان غربی', 'اردبیل', 'اصفهان', 'البرز', 'ایلام', 'بوشهر', 'تهران', 'خراسان جنوبی', 'خراسان رضوی', 'خراسان شمالی', 'خوزستان', 'زنجان',
  'سمنان', 'سیستان و بلوچستان', 'فارس', 'قزوین', 'قم', 'لرستان', 'مازندران', 'مرکزی', 'هرمزگان', 'همدان', 'چهارمحال و بختیاری', 'کردستان', 'کرمان', 'کرمانشاه',
  'کهگیلویه و بویراحمد', 'گلستان', 'گیلان', 'یزد'
]

states_list.each do |name|
  State.create!(name: name)
end
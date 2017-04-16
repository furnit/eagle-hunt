# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#
# => ading user types
#
[
  ['ادمین', 'ADMIN', 'ادمین سایت، دسترسی کامل به کل سایت' ,1001],
  ['مشتری', 'CLIENT','مشتری سایت که دسترسی عمومی به محتویات سایت دارد',1],
  ['فنی', 'FANI','موجودیت خیاط کار، امکان دسترسی به ارزیابی اطلاعات جزییات ساخت مبل',2],
  ['نجار', 'NAJAR','موجودیت نجار، امکان دسترسی به ارزیابی اطلاعات نجاری و کنده‌کاری مبلمان‌ها ',2],
  ['نقاش', 'NAGASH','موجودیت نقاش کار، امکان دسترسی به ارزیابی اطلاعات نقاشی مبلمان‌ها ',2],
  ['کارشناس گرافیک', 'GRAPHIC','بررسی گرافیکی و سلیقه‌ای محصولات و ثبت پیشنهادات مرتبط',2],
  ['بازاریاب', 'MARKETER','بازاریاب‌ محصولات',2],
  ['بازرس', 'PR','بازرسی کیفی فعالیت‌های بازاریاب‌ها، روابط عمومی مشتری‌ها',3],
  ['بازارسنج', 'MARKLINE','مسئول بروز رسانی قیمت‌های کالاها و لوازم پیش‌نیاز محصولات خدماتی',2]
]
.each do |name, symbol, comment, auth_level|
  Admin::UserType.create(name: name, symbol: symbol, comment: comment, auth_level: auth_level)
end

#
# => adding states
#
[
  'آذربایجان شرقی', 'آذربایجان غربی', 'اردبیل', 'اصفهان', 'البرز', 'ایلام', 'بوشهر', 'تهران', 'خراسان جنوبی', 'خراسان رضوی', 'خراسان شمالی', 'خوزستان', 'زنجان',
  'سمنان', 'سیستان و بلوچستان', 'فارس', 'قزوین', 'قم', 'لرستان', 'مازندران', 'مرکزی', 'هرمزگان', 'همدان', 'چهارمحال و بختیاری', 'کردستان', 'کرمان', 'کرمانشاه',
  'کهگیلویه و بویراحمد', 'گلستان', 'گیلان', 'یزد'
]
.each do |name|
  State.create!(name: name)
end

#
# => adding admins
#
[
  '09120686119',
]
.each do |phone_number|
  User.create!(
    phone_number: phone_number,
    password: phone_number,
    password_confirmation: phone_number,
    admin_user_type_id: Admin::UserType.where('symbol = ?', :ADMIN.to_s).first.id,
    change_password: true
  )
end

#
# => adding admins' profile
#
[
  ['داریوش', 'حسن‌پور', 'اصفهان']
]
.each.with_index do |data, index|
  Profile.create!(first_name: data[0], last_name: data[1], state_id: State.where('name = ?', data[2]).first.id, address: data[2], user_id: index + 1)
end

#
# => adding furniture section details
#
[
  ['پشتی', 'قسمت تکیه‌گاه و پشت مبل', "data/images/sofa/poshti.jpg"],
  ['زیری', 'قسمت تحتانی و نشیمن‌گاه', "data/images/sofa/ziri.jpg"],
  ['دسته', 'دسته‌های مبل', "data/images/sofa/daste.jpg"],
  ['پایه', 'پایه‌های مبل', "data/images/sofa/paye.jpg"],
  ['کوسن', 'بالشتک‌های مبل', "data/images/sofa/kosan.jpg"]
]
.each do |name, comment, image|
  section = Admin::FurnitureSection.create!(name: name, comment: comment)
  section.images = [Rails.root.join(image).open]
  section.save!
end

#
# => adding types of abrs
#
[
  '۳۰ کیلویی',
  '۲۰ کیلویی',
  '۱۰ کیلویی',
]
.each.with_index do |name, index|
  Admin::FurnitureStuffAbr.create!(name: name, value: 3 - index)
end

[
  ['ابر', 'ورق'],
  ['پارچه', 'متر']
]
.each do |name, scale|
  Admin::FurnitureSpec.create!(name: name, scale: scale, comment: name)
end

target_asset = Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb")

load(target_asset) if File.file?(target_asset)
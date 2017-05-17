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
  ['نجار', 'NAJAR','موجودیت نجار، امکان دسترسی به ارزیابی اطلاعات نجاری و نیمه‌کنده‌کاری مبلمان‌ها ',2],
  ['کلاف‌کار', 'KALAF','موجودیت کلاف‌کار، امکان دسترسی به ارزیابی اطلاعات کلاف‌کاری مبلمان‌ها',2],
  ['نقاش', 'NAGASH','موجودیت نقاش کار، امکان دسترسی به ارزیابی اطلاعات نقاشی مبلمان‌ها ',2],
  ['کارشناس گرافیک', 'GRAPHIC','بررسی گرافیکی و سلیقه‌ای محصولات و ثبت پیشنهادات مرتبط',2],
  ['بازاریاب', 'MARKETER','بازاریاب‌ محصولات',2],
  ['بازرس', 'PR','بازرسی کیفی فعالیت‌های بازاریاب‌ها، روابط عمومی مشتری‌ها',3],
  ['بازارسنج', 'MARKLINE','مسئول بروز رسانی قیمت‌های کالاها و لوازم پیش‌نیاز محصولات خدماتی',2],
  ['مدیر‌کارگاه', 'WORKSHOP_MANAGER', 'مسئول مدیریت کارگاه', 100]
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
  '09120535348'
]
.each do |phone_number|
  User.create!(
    phone_number: phone_number,
    password: phone_number,
    password_confirmation: phone_number,
    admin_user_type_id: Admin::UserType.where('symbol = ?', :ADMIN.to_s).first.id
  )
  .reset_password
  .save
end

#
# => adding admins' profile
#
[
  ['داریوش', 'حسن‌پور', 'اصفهان'],
  ['سیاوش', 'حسن‌پور', 'آذربایجان غربی']
]
.each.with_index do |data, index|
  Profile.create!(first_name: data[0], last_name: data[1], state_id: State.where('name = ?', data[2]).first.id, address: data[2], user_id: index + 1)
end

#
# => adding furniture section details
#
[
  ['پشتی', 'قسمت تکیه‌گاه و پشت', 'NECESSARY', "data/images/sofa/poshti.png"],
  ['زیری', 'قسمت تحتانی و نشیمن‌گاه', 'NECESSARY', "data/images/sofa/ziri.png"],
  ['دسته', 'دسته‌ها', 'NECESSARY', "data/images/sofa/daste.png"],
  ['پایه', 'پایه‌ها', 'OPTIONAL', "data/images/sofa/paye.png"],
  ['کوسن', 'بالشتک‌ها', 'OPTIONAL', "data/images/sofa/kosan.png"]
]
.each do |name, comment, tag, image|
  section = Admin::Furniture::Section.create!(name: name, tag: tag, comment: comment)
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
.each do |name|
  Admin::Furniture::FoamType.create!(name: name)
end

[
  ['ابر', 'ورق'],
  ['پارچه', 'متر'],
  ['رنگ', 'لیتر'],
  ['چوب', 'متر']
]
.each do |name, unit|
  Admin::Furniture::Spec.create!(name: name, unit: unit, comment: name)
end

(1..3).each do |i|
  Admin::Furniture::Piece.create(piece: i, comment: "مبل #{i} نفره")
end

[
  [3, 2, 1, 1],
  [3, 2, 1, 1, 1],
  [3, 2, 2, 1, 1]
]
.each do |config|
  Admin::Furniture::Set.create!(name: "ست #{config.sum} نفره", config: config, total_count: config.sum)
end

target_asset = Rails.root.join( 'db', 'seeds', "#{Rails.env.downcase}.rb")

load(target_asset) if File.file?(target_asset)

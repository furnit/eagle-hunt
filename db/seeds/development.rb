require_relative 'utils'

[
  ['راحتی', 'data/images/samples/furnitures/1/sample-1.jpg']
]
.each do |name, image|
  type = Admin::Furniture::Type.create(name: name, comment: name)
  type.images = upload_files image
  type.save!
end


[
  ['گلزاد', 'data/images/samples/furnitures/1/sample*.jpg'],
  ['بهارک', 'data/images/samples/furnitures/2/sample*.jpg']
]
.each do |name, pattern|
  fur = Admin::Furniture::Furniture.create(name: name, comment: name, furniture_type_id: 1)
  fur.images = upload_files Dir.glob(pattern)
  fur.save!
end
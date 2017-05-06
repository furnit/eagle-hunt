[
  ['راحتی', 'data/images/samples/furnitures/1/sample-1.jpg']
]
.each do |name, image|
  type = Admin::Furniture::Type.create(name: name, comment: name)
  type.images = [Rails.root.join(image).open]
  type.save!
end


[
  ['گلزاد', 'data/images/samples/furnitures/1/sample*.jpg'],
  ['بهارک', 'data/images/samples/furnitures/2/sample*.jpg']
]
.each do |name, pattern|
  fur = Admin::Furniture::Furniture.create(name: name, comment: name, furniture_type_id: 1)
  images = []
  Dir.glob(pattern).each { |image| images << Pathname.new(Rails.root.join(image)).open }
  fur.images = images
  fur.save!
end
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

fabrange = (1..3)
# fabric images
fabimages = Dir.glob("data/images/samples/fabrics/*.jpg")
fabsplits = fabimages.in_groups_of(3, false)
fabstack  = []
# split images into proportions
fabprop   = [0, 0.5, 0.35, 0.15]
fabprop[1..-1].each.with_index do |p, index|
  details = {
    indices: [index, index + 1],
    props: [fabprop[0..index].sum, fabprop[0..index].sum + p],
    splits: [(fabprop[0..index].sum * fabsplits.length), ((fabprop[0..index].sum + p) * fabsplits.length)].map(&:to_i)
  }
  fabstack << fabsplits[details[:splits].first..details[:splits].last - (details[:splits].first == details[:splits].last ? 0 : 1)].flatten
end

raise Exception.new("size doesn't match!") if fabrange.to_a.length != fabstack.length

fabrange.each do |type|
  Admin::Furniture::Fabric::Quality.create!(name: "درجه #{type}", comment: "پارچه درجه #{type}")
end

fabrange.each do |brand|
  Admin::Furniture::Fabric::Brand.create!(name: "برند #{brand}", comment: "پارچه برند #{brand}")
end

fabrange.each do |idx|
  f = Admin::Furniture::Fabric::Fabric.create!(type: Admin::Furniture::Fabric::Quality.find(idx), brand: Admin::Furniture::Fabric::Brand.find(idx))
  upload_files(fabstack).each do |idx|
    Admin::Furniture::Fabric::Model.create!(name: "M#{idx}", fabric: f, image: idx)
  end
end

# cluster colors
k = 7
Admin::Furniture::FabricColor.cluster k, runs: AppConfig.fabric.colours.cluster.runs
Admin::Furniture::Fabric::Fabric.all.each { |f| f.determine_colour }

# define constant 
const_price = Admin::Pricing::Const.columns_hash.keys.reject { |i| [:id, :updated_at, :created_at].include? i.to_sym }.map { |i| {"#{i}": 20000 }}.reduce({}, :merge)
const_price[:extra] = 200000
Admin::Pricing::Const.create! const_price

Admin::Furniture::Fabric::Brand.all.each.with_index do |brand, index|
  Admin::Pricing::Fabric.create!(brand: brand, price: (5e+4 - 1e+4 * index).abs)
end

Admin::Furniture::FoamType.all.each.with_index do |type, index|
  Admin::Pricing::Foam.create!(type: type, price: (2e+4 - 5e+3 * index).abs)
end

Admin::Pricing::Kalaf.create!(price: 15e+3)

Admin::Selling::Config::Profit.create!(overall: 20, marketer: 3, marketed: 5e+4, marketed_fixed: true)

[
  [1, 0.325],
  [2, 0.225],
  [3, 0.125]
]
.each do |piece, percentage|
  Admin::Selling::Config::PiecePrice.create!(set: Admin::Furniture::Set.prefered, piece: Admin::Furniture::Piece.find_by_piece(piece), percentage: percentage)
end

Admin::Selling::Config::DaysToComplete.create!(extra: 2)
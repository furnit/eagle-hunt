module ComputePrice
  def self.execute furniture, set:, fabric_brand_id: nil, wood_type_id: nil, paint_color_brand_id: nil
    # get all pieces together
    set_pieces = Hash[set.map {|x| [x, Admin::Selling::Config::PiecePrice.find_by(piece: x)]}]
    # if not all pieces' price not defined? 
    raise RuntimeError.new("یک یا چند عدد از مشخصات ست مورد نظر، قیمت‌گذاری نشده است.") if not set_pieces.values.all?
    # get all factors together
    factors = {
      const: Admin::Pricing::Const.last,
      fabric: Admin::Pricing::Fabric.find_by(admin_furniture_fabric_brand_id: fabric_brand_id),
      paint_color: Admin::Pricing::PaintColor.find_by(admin_furniture_paint_color_brand_id: paint_color_brand_id),
      paint_astar_rouye: Admin::Pricing::PaintAstarRouye.last,
      wood: Admin::Pricing::Wood.find_by(admin_furniture_wood_type_id: wood_type_id),
      kalaf: Admin::Pricing::Kalaf.last
    }
    # define overall cost
    cost = 0
    # compute cost based on factors 
    base_cost = furniture.compute_cost **factors
    # compute overall cost
    set.each { |s| cost += (base_cost * set_pieces[s].percentage) }
    # return cost
    cost
  end
  
end
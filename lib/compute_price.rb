module ComputePrice
  def self.execute furniture, set:, fabric_brand_id: nil, wood_type_id: nil, paint_color_brand_id: nil
    # consider same fabric brand for all part of furniture
    fabric = Admin::Pricing::Fabric.find_by(admin_furniture_fabric_brand_id: fabric_brand_id)
    # get all factors together
    factors = {
      const: Admin::Pricing::Const.last,
      fabrics: {
        ziri: fabric,
        daste: fabric,
        poshti: fabric
      },
      paint_color: Admin::Pricing::PaintColor.find_by(admin_furniture_paint_color_brand_id: paint_color_brand_id),
      paint_astar_rouye: Admin::Pricing::PaintAstarRouye.last,
      wood: Admin::Pricing::Wood.find_by(admin_furniture_wood_type_id: wood_type_id),
      kalaf: Admin::Pricing::Kalaf.last
    }
    furniture.compute_price factors: factors, set: set
  end
end
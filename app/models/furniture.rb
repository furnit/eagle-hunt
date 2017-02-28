class Furniture < ApplicationRecord  
  mount_uploaders :images, FurnitureUploader
  
  def cost?
    f = CostFactor.last;
    cost = 0.0;
    %w[size_parche size_kanaf size_abr wage_khayat wage_rokob wage_naghash wage_najar wage_extra transfer_counts].each do |i|
      cost += (self[i].to_i * f[i].to_i);
    end
    return (cost + f[:extras]) * (1 + f[:profit_percentage] / 100.0)
  end
  
end

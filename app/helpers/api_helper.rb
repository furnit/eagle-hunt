module ApiHelper
  def self.compute_transit_cost params, method:
    price = 0
    case method.downcase.to_sym
    when :max
      price  = Admin::Pricing::Transit.where(state_id: params[:state_id]).pluck(:price).max
    when :min
      price  = Admin::Pricing::Transit.where(state_id: params[:state_id]).pluck(:price).min
    when :place
      price  = Admin::Pricing::Transit.where(state_id: params[:state_id], admin_workshop_workshop_id: params[:workshop_id]).pluck(:price).first
    else
      raise RuntimeError.new("invalid method `#{method}`");
    end
    return price
  end
end

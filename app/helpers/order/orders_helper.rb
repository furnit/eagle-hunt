module Order::OrdersHelper
  include ComputePrice
  def histogram data
    data.inject(Hash.new(0)) {|hash, word| hash[word] += 1; hash }
  end
end

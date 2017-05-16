class Numeric
  def tomans
    self / 1000
  end
  def thousand_tomans
    self * 1000
  end
  def stepize step
    ((self / step).ceil * step).ceil
  end
end
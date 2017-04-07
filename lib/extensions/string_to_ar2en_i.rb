class String
  def to_ar2en_i
    self.tr!('۰۱۲۳۴۵۶۷۸۹','0123456789') || self
  end
end
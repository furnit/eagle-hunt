class String
  def to_ar2en_i
    self.tr!('۰۱۲۳۴۵۶۷۸۹','0123456789') || self
  end
  
  def to_boolean
    self == 'true' || self == '1'
  end

  def numeric?
    return true if self =~ /\A\d+\Z/
    true if Float(self) rescue false
  end

  def to_money
    str = self.dup
    str = str.gsub ",", ""
    return str if not str.numeric?
    sign = ""
    if str[0] =~ /[\+\-]/
      sign = str[0]
      str = str[1..-1]
    end
    sp = str.split "."
    out = sign
    sp.each.with_index { |s, index| out += ((index > 0 ? "." : "") + s.reverse.scan(/.{1,3}/).map(&:reverse).reverse.join(',')) }
    out
  end
  
  def lang?
    CLD.detect_language(self)
  end
  
  def is_arabic?  
    [:fa, :ar, :ur].include? self.lang?[:code].to_sym
  end
end
module NumericExtension
  def to_sql
    self
  end
end

Numeric.send :include, NumericExtension
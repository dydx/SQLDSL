class Numeric
  include WhereValue
  # call-seq: numeric.to_sql -> a_numeric
  # 
  # Returns self
  # 
  #    10.to_sql     #=> 10
  def to_sql
    self
  end
end
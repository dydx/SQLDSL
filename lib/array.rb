class Array
  def to_sql
    self.collect { |element| element.to_sql }.join(', ')
  end
  
  def to_sql_equal(lval)
    "#{lval.to_sql } in (#{ self.to_sql })" 
  end
end
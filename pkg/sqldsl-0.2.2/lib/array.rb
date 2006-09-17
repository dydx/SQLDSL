class Array
  # call-seq: array.to_sql -> a_string
  # 
  # Returns a string by collecting all elements, calling +to_sql+ on each one, and 
  # then joins them with ', '.
  # 
  #    [10, 'book', :column2].to_sql     #=> "10, 'book', column2"
  def to_sql
    self.collect { |element| element.to_sql }.join(', ')
  end
  
  # call-seq: array.to_sql_equal(any) -> a_string
  # 
  # Returns a string containing the sql in expression
  # 
  #    [10, :column2, 'book'].to_sql_equal(:column1)       #=> "column1 in (10, column2, 'book')"
  def to_sql_equal(lval)
    "#{lval.to_sql } in (#{ self.to_sql })" 
  end
end
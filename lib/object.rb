class Object

  # call-seq: obj.to_sql_equal(any) -> a_string
  # 
  # Returns a string containing the sql equality expression
  # 
  #    10.to_sql_equal(:column1)       #=> "column1 = 10"
  def to_sql_equal(lval)
    sql_expression(lval, "=")
  end
  
  def to_sql_more_than(lval) #:nodoc:
    sql_expression(lval, ">")
  end
  
  def to_sql_less_than(lval) #:nodoc:
    sql_expression(lval, "<")
  end
  
  def to_sql_less_than_or_equal_to(lval) #:nodoc:
    sql_expression(lval, "<=")
  end

  def to_sql_more_than_or_equal_to(lval) #:nodoc:
    sql_expression(lval, ">=")
  end  

  protected

  def sql_expression(lval, operator) #:nodoc:
    "#{ lval.to_sql } #{operator} #{ self.to_sql }"
  end

end
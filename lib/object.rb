module ObjectExtension

  def to_sql_equal(lval)
    sql_expression(lval, "=")
  end
  
  def to_sql_more_than(lval)
    sql_expression(lval, ">")
  end
  
  def to_sql_less_than(lval)
    sql_expression(lval, "<")
  end
  
  def to_sql_less_than_or_equal_to(lval)
    sql_expression(lval, "<=")
  end

  def to_sql_more_than_or_equal_to(lval)
    sql_expression(lval, ">=")
  end  

  protected

  def sql_expression(lval, operator)
    "#{ lval.to_sql } #{operator} #{ self.to_sql }"
  end

end

Object.send :include, ObjectExtension
class WhereBuilder  
  def initialize(&block)
    instance_eval(&block)
  end
  
  def equal(lval, rval)
    sql_parts << rval.to_sql_equal(lval)
  end
    
  def exists(clause)
    sql_parts << "exists (#{clause.to_sql})"
  end
  
  def not_exists(clause)
    sql_parts << "not exists (#{clause.to_sql})"
  end
  
  def to_sql
    " where #{sql}"
  end
  
  protected
  
  def sql
    sql_parts.join(' and ')
  end
  
  def sql_parts
    @sql_parts ||= []
  end
  
end
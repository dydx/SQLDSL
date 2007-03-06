class WhereBuilder
  attr_reader :tables
  
  # call-seq: WhereBuilder.new(&block) -> a_where_builder
  # 
  # Returns a new WhereBuilder.  At initialization time the block is instance evaled on the
  # new WhereBuilder instance.
  # 
  #    WhereBuilder.new { equal :column1, 10 }.to_sql       #=> " where column1 = 10"
  def initialize(tables, &block)
    @tables = tables
    instance_eval(&block)
  end
  
  # call-seq: where.equal(arg1, arg2)
  # 
  # Appends an equality condition to the where SQL clause.
  # 
  #    WhereBuilder.new { equal :column1, 10 }.to_sql       #=> " where column1 = 10"
  def equal(lval, rval)
    sql_parts << rval.to_sql_equal(lval)
  end
  
  # call-seq: where.not_null(arg1)
  # 
  # Appends a not null condition to the where SQL clause.
  # 
  #    WhereBuilder.new { not_null :column1 }.to_sql       #=> " where column1 is not null"
  def not_null(column)
    sql_parts << "#{column} is not null"
  end
    
  # call-seq: where.exists(clause)
  # 
  # Appends an exists condition to the where SQL clause.
  # 
  #    WhereBuilder.new { exists 'select id from table1' }.to_sql       #=> " where exists (select id from table1)"
  def exists(clause)
    sql_parts << "exists (#{clause.to_sql})"
  end
  
  # call-seq: where.not_exists(clause)
  # 
  # Appends an exists condition to the where SQL clause.
  # 
  #    WhereBuilder.new { not_exists 'select id from table1' }.to_sql       #=> " where not exists (select id from table1)"
  def not_exists(clause)
    sql_parts << "not exists (#{clause.to_sql})"
  end
  
  # call-seq: where.to_sql -> a_string
  # 
  # Returns a string by collecting all the conditions and joins them with ' and '.
  # 
  #    WhereBuilder.new do 
  #      equal :column1, 10
  #      equal :column2, 'book'
  #    end.to_sql         #=> " where column1 = 10 and column2 = 'book'"
  def to_sql
    " where #{sql_parts.join(' and ')}"
  end
  
  def sql_parts #:nodoc:
    @sql_parts ||= []
  end
  
  def method_missing(sym, *args) #:nodoc:
    ReceiveAny.new(sym, self)
  end
  
end
class ReceiveAny  #:nodoc:
  attr_reader :to_sql
  
  def initialize(identifier, builder)
    @to_sql = identifier.to_s
    @builder = builder
  end
  
  def <=(arg)
    @builder.sql_parts << "#{self.to_sql} <= #{arg.to_sql}"
  end
  
  def >=(arg)
    @builder.sql_parts << "#{self.to_sql} >= #{arg.to_sql}"
  end
  
  def <=>(arg)
    self.not_equal(arg)
  end
  
  def <(arg)
    @builder.sql_parts << "#{self.to_sql} < #{arg.to_sql}"
  end
  
  def >(arg)
    @builder.sql_parts << "#{self.to_sql} > #{arg.to_sql}"
  end
  
  def not_equal(arg)
    @builder.sql_parts << "#{self.to_sql} <> #{arg.to_sql}"
  end
  
  def append_on_setter(lval, rval)
    @builder.equal(lval.to_sym, rval)
  end
  
  def method_missing(sym, *args)
    raise "#{self.to_sql} is not specified as a table in your from statement" unless @builder.tables.include?(self.to_sql.to_sym)
    @to_sql << ".#{sym.to_s}".chomp("=")
    append_on_setter(self.to_sql, args.first) if sym.to_s =~ /=$/
    self
  end
end
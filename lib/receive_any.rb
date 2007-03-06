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
  
  def append_on_setter(lval, rval)
    @builder.equal(lval.to_sym, rval)
  end
  
  def method_missing(sym, *args)
    @to_sql << ".#{sym.to_s}".chomp("=")
    append_on_setter(self.to_sql, args.first) if sym.to_s =~ /=$/
    self
  end
end
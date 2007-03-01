module WhereValue
  
  def is_not_in &block
    builder = eval "self", block.binding
    builder.sql_parts << "#{self.to_sql} not in (#{block.call.to_sql})"
  end
  
end
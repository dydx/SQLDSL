class AndWithOrConditionsWhereBuilder < WhereBuilder #:nodoc:
  def to_sql 
    " and (#{sql_parts.join(' or ')})"
  end
end

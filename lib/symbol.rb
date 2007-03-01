class Symbol
  include WhereValue
  # call-seq: symbol.to_sql -> a_string
  # 
  # Returns a string with single quotes escaped.
  # 
  #    "it's".to_sql     #=> "'it''s'"
  def to_sql
    to_s
  end  

end
class String
  
  # call-seq: string.to_sql -> a_string
  # 
  # Returns a string with single quotes escaped.
  # 
  #    :book.to_sql     #=> "book"
  def to_sql
    "'#{self.gsub(/'/, "''")}'"
  end

end
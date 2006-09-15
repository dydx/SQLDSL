class String
  
  def to_sql
    "'#{self.gsub(/'/, "''")}'"
  end

end
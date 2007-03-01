class Hash
  
  # call-seq: hash.to_sql -> a_string
  # 
  # Returns a string with single quotes escaped.
  # 
  #    {:column1 => :foo, :column2 => :bar}.to_sql     #=> "column1 as foo, column2 as bar"
  def to_sql
    result = []
    each_pair do |key, value|
      result << :"#{key} as #{value}"
    end
    result.sort{|x,y| x.to_s <=> y.to_s}.to_sql
  end

end
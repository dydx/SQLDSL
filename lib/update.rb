class Update < SqlStatement
  class << self
    def [](table)
      self.new("update #{table.to_sql}")
    end
  end
  
  def set
    self
  end
  
  def [](hash)
    @to_sql += " set "
    set_args = []
    hash.each_pair do |col, val|
      set_args << "#{col.to_sql}=#{val.to_sql}"
    end
    @to_sql += set_args.sort.join(', ')
    self
  end
end
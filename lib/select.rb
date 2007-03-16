class Select < SqlStatement
  class << self
    # call-seq: Select[arg,...] -> a_select
    # 
    # Returns a Select instance with the SQL initialized to 'select ' plus the args joined by ', '
    # 
    #    Select[1, :column1, 'book'].to_sql       #=> "select 1, column1, 'book'"
    def [](*columns)
      self.new("select #{columns.to_sql}")
    end
    
    # call-seq: Select.distinct -> a_select
    # 
    # Returns a Select class that appends 'distinct' to the select clause
    # 
    #    Select.distinct[1, :column1, 'book'].to_sql       #=> "select distinct 1, column1, 'book'"
    def distinct
      DistinctSelect
    end
    
    # call-seq: Select.all -> a_select
    # 
    # Returns a Select instance with the SQL initialized to 'select *'
    # 
    #    Select.all.to_sql       #=> "select *"
    def all
      self.new("select *")
    end

  end
  
  # call-seq: select.from -> a_select
  # 
  # Returns a Select instance with ' from ' appended to the SQL statement.
  # 
  #    Select[1, :column1, 'book'].from.to_sql       #=> "select 1, column1, 'book' from "
  def from
    @to_sql += " from "
    self
  end
  
  # call-seq: select[table,...] -> a_select
  # 
  # Returns a Select instance with the table names, joined by ', ' appended to the SQL statement.
  # 
  #    Select[1, :column1, 'book'].from[:table1, :table2].to_sql       #=> "select 1, column1, 'book' from table1, table2"
  def [](*table_names)
    @tables = []
    @to_sql += table_names.inject([]) do |result, element|
      if element.to_s =~ / as /
        @tables << element.to_s.split(/ as /).last.to_sym
        result << element.to_s.gsub(/ as /, " ").to_sym
      else
        @tables << element
        result << element
      end
    end.to_sql
    self
  end
  
  # call-seq: select.order_by -> a_select
  # 
  # Returns a Select instance with the order arguments, joined by ', ' appended to the SQL statement.
  # 
  #    Select[1].from[:table1].order_by(:column1, :column2).to_sql       #=> "select 1 from table1 order by column1, column2"
  def order_by(*column)
    @to_sql << " order by #{column.to_sql}"
    self
  end
  
end
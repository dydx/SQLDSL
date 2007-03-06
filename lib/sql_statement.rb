class SqlStatement
  attr_reader :to_sql, :tables

  def initialize(sql)  #:nodoc:
    @to_sql = sql
  end
  
  # call-seq: sql_statement.where { block } -> a_sql_statement
  # 
  # Creates a new WhereBuilder instance, passing the block as a parameter, then executes to_sql on the WhereBuilder instance.
  # The resulting string from the WhereBuilder instance is appended to the SQL statement.
  # Returns self.
  # 
  #    Select[1].where { equal :column1, 1 }.to_sql       #=> "select 1 where column1 = 1"
  def where(&block)
    @to_sql += WhereBuilder.new(self.tables, &block).to_sql
    self
  end
end
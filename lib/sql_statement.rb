class SqlStatement
  attr_reader :to_sql

  def initialize(sql)
    @to_sql = sql
  end
  
  def where(&block)
    @to_sql += WhereBuilder.new(&block).to_sql
    self
  end
end
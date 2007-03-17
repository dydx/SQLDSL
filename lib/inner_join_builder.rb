class InnerJoinBuilder
  def initialize(select_builder)
    @select_builder = select_builder
  end
  
  def [](table_name)
    @select_builder.inner_join_table(table_name)
  end
end
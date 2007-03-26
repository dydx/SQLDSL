require File.dirname(__FILE__) + '/test_helper'

class InnerJoinBuilderTest < Test::Unit::TestCase
  def test_add_tables
    ij = InnerJoinBuilder.new(s_builder = mock)
    s_builder.expects(:inner_join_table).with([:"table1 as foo"])
    ij[:table1.as(:foo)]
  end
end
require File.dirname(__FILE__) + '/test_helper'

class JoinBuilderTest < Test::Unit::TestCase
  def test_add_tables
    ij = JoinBuilder.new(s_builder = mock, "inner")
    s_builder.expects(:join_table).with("inner", [:"table1 as foo"])
    ij[:table1.as(:foo)]
  end
end
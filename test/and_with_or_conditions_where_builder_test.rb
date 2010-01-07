require File.dirname(__FILE__) + '/test_helper'

class AndWithOrConditionsWhereBuilderTest < Test::Unit::TestCase

  def test_to_sql
    statement = AndWithOrConditionsWhereBuilder.new [] do
      not_equal :column1, :column2
      equal :column2, 100
    end
    assert_equal " and (column1 <> column2 or column2 = 100)", statement.to_sql
  end
end
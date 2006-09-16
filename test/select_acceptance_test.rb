require File.dirname(__FILE__) + '/test_helper'

class SelectAcceptanceTest < Test::Unit::TestCase
  def test_simple_select
    statement = Select[:column1, 'book', 10].from[:table1].where do
      equal :column1, 99
      equal :column2, 'star'
    end
    expected = "select column1, 'book', 10 from table1 where column1 = 99 and column2 = 'star'"
    assert_equal expected, statement.to_sql
  end
  
  def test_select_with_join
    statement = Select[:column1, :column2].from[:table1, :table2].where do
      equal :'table1.id', :'table2.table1_id'
    end
    expected = "select column1, column2 from table1, table2 where table1.id = table2.table1_id"
    assert_equal expected, statement.to_sql
  end
end
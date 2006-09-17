require File.dirname(__FILE__) + '/test_helper'

class InsertAcceptanceTest < Test::Unit::TestCase
  def test_insert_select
    statement = Insert.into[:table1][:column1, :column2, :column3].values do
      Select[1]
    end
    assert_equal 'insert into table1 (column1, column2, column3) select 1', statement.to_sql
  end
  
  def test_insert_with_values
    statement = Insert.into[:table1][:column1, :column2, :column3].values(10, 'book', :column4)
    assert_equal "insert into table1 (column1, column2, column3) values (10, 'book', column4)", statement.to_sql
  end
end
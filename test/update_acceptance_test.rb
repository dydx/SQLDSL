require File.dirname(__FILE__) + '/test_helper'

class UpdateAcceptanceTest < Test::Unit::TestCase
  def test_insert_select
    statement = Update[:table1].set[:column1=>10, :column2=>'book'].where do
      not_exists(Select[1].from[:table2])
    end
    assert_equal "update table1 set column1=10, column2='book' where not exists (select 1 from table2)", statement.to_sql
  end
end
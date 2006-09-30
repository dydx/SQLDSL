require File.dirname(__FILE__) + '/test_helper'

class DeleteAcceptanceTest < Test::Unit::TestCase
  def test_insert_select
    statement = Delete.from[:table1].where do
      exists(Select[1].from[:table2])
    end
    assert_equal "delete from table1 where exists (select 1 from table2)", statement.to_sql
  end
end
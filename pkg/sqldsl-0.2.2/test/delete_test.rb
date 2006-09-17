require File.dirname(__FILE__) + '/test_helper'

class DeleteTest < Test::Unit::TestCase 

  def test_delete_without_where_clause
    assert_equal 'delete from foo', Delete.from[:foo].to_sql
  end

  def test_delete_with_where_clause
    statement = Delete.from[:table].where do
      equal :'table.column1', :'table.column2'
    end
    assert_equal 'delete from table where table.column1 = table.column2', statement.to_sql
  end
    
  def test_delete_with_select_statement_including_tables_from_delete_context
    statement = Delete.from[:potential_account_offers].where do
      exists(Select[:'potential_account_offers.id'].from[:foo].where do
        equal :'potential_account_offers.id', :'foo.bar' 
      end)
    end
    expected = 'delete from potential_account_offers where exists (select potential_account_offers.id from foo where potential_account_offers.id = foo.bar)'
    assert_equal expected, statement.to_sql
  end
  
  def test_if_where_is_called_with_no_block_gives_reminder_to_use_parents
    assert_raise(ArgumentError) do
      statement = Delete.from[:potential_account_offers].where do
        exists Select[:'potential_account_offers.id'].from[:foo].where do
          equal :'foo.id', :'foo.bar' 
        end
      end
    end
  end

end 

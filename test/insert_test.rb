require File.dirname(__FILE__) + '/test_helper'

class InsertTest < Test::Unit::TestCase 

  def test_table_name_saved
    assert_equal "insert into table", Insert.into[:table].to_sql
  end
  
  def test_insert_with_statement_block
    statement = Insert.into[:foo].values do
      Struct.new(:to_sql).new('stupid')
    end
    assert_equal "insert into foo stupid", statement.to_sql    
  end
    
  def test_insert_with_explicit_column_order
    statement = Insert.into[:foo][:column1, :column2].values do
      Struct.new(:to_sql).new('whee')
    end
    assert_equal "insert into foo (column1, column2) whee", statement.to_sql
  end
    
  def test_insert_with_multiple_sql_statements_in_block_uses_last
    statement = Insert.into[:foo].values do
      Struct.new(:to_sql).new('woo')
      Struct.new(:to_sql).new('hoo')
    end
    assert_equal "insert into foo hoo", statement.to_sql
  end
end 


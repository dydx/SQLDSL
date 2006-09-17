require File.dirname(__FILE__) + '/test_helper'

class InsertTest < Test::Unit::TestCase 

  def test_table_name_saved
    assert_equal "insert into table", Insert.into[:table].to_sql
  end
  
  def test_insert_with_statement_block
    statement = Insert.into[:foo].values do
      Struct.new(:to_sql).new('bar')
    end
    assert_equal "insert into foo bar", statement.to_sql    
  end
    
  def test_insert_with_explicit_column_order
    statement = Insert.into[:foo][:column1, :column2].values do
      Struct.new(:to_sql).new('more')
    end
    assert_equal "insert into foo (column1, column2) more", statement.to_sql
  end
    
  def test_insert_with_multiple_sql_statements_in_block_uses_last
    statement = Insert.into[:foo].values do
      Struct.new(:to_sql).new('woo')
      Struct.new(:to_sql).new('hoo')
    end
    assert_equal "insert into foo hoo", statement.to_sql
  end


  def test_values_WITH_no_block
    statement = Insert.into[:foo].values(10, :book)
    assert_equal "insert into foo values (10, book)", statement.to_sql
  end
end 


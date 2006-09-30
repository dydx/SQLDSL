require File.dirname(__FILE__) + '/test_helper'

class SelectTest < Test::Unit::TestCase 
  def test_select_with_single_column
    assert_equal 'select foo', Select[:foo].to_sql
  end

  def test_select_with_multiple_columns
    assert_equal 'select foo, bar', Select[:foo, :bar].to_sql
  end
  
  def test_time_literals_quoted
    time = Time.at(946702800)
    assert_equal "select to_timestamp('2000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')", Select[time].to_sql
  end
  
  def test_select_with_symbol_and_literal_columns
    assert_equal "select symbol, 'literal'", Select[:symbol, 'literal'].to_sql
  end
  
  def test_select_with_single_table
    assert_equal 'select foo from foo', Select[:foo].from[:foo].to_sql
  end
    
  def test_select_with_multiple_tables
    assert_equal 'select column from bar, foo',
                 Select[:column].from[:foo, :bar].to_sql
  end
end 

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
    assert_equal 'select column from foo, bar', Select[:column].from[:foo, :bar].to_sql
  end
  
  def test_order_by
    assert_equal 'select foo order by bar', Select[:foo].order_by(:bar).to_sql
  end
  
  def test_order_by_with_multiple_arguments
    assert_equal 'select foo order by bar, baz', Select[:foo].order_by(:bar, :baz).to_sql
  end
  
  def test_distinct_select
    assert_equal 'select distinct foo', Select.distinct[:foo].to_sql
  end
  
  def test_column_aliasing
    assert_equal "select column1 as foo, 2 as bar, 'foo' as baz", Select[:column1.as(:foo), 2.as(:bar), 'foo'.as(:baz)].to_sql
  end
  
  def test_table_aliasing
    assert_equal 'select * from table1 foo, table2 bar, table3', Select.all.from[:table1.as(:foo), :table2.as(:bar), :table3].to_sql
  end
  
  def test_tables_no_aliasing
    assert_equal 'select * from table1, table2', Select.all.from[:table1, :table2].to_sql
  end
  
  def test_select_all
    assert_equal 'select *', Select.all.to_sql
  end
  
  def test_table_array
    assert_equal [:table1, :table2], Select.all.from[:table1, :table2].instance_variable_get("@tables")
  end

  def test_left_join_with_table
    assert_equal "select * from table1 left join table2", Select.all.from[:table1].left_join[:table2].to_sql
  end

  def test_right_join_with_table
    assert_equal "select * from table1 right join table2", Select.all.from[:table1].right_join[:table2].to_sql
  end

  def test_inner_join_with_table
    assert_equal "select * from table1 inner join table2", Select.all.from[:table1].inner_join[:table2].to_sql
  end

  def test_inner_join_with_table_with_on
    statement = Select.all.from[:table1].inner_join[:table2].on do
      table2.column == 1
    end
    assert_equal "select * from table1 inner join table2 on table2.column = 1", statement.to_sql
  end
  
end 

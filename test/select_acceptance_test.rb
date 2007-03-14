require File.dirname(__FILE__) + '/test_helper'

class SelectAcceptanceTest < Test::Unit::TestCase
  def test_select_with_where_methods
    statement = Select[:column1, 'book', 10].from[:table1, :table2].where do
      equal :column1, 99
      not_equal :column1, 100
      less_than :column2, 'foo'
      less_than_or_equal :column3, :column4
      greater_than :column1, 0
      greater_than_or_equal :column2, 'bar'
      is_not_null :column1
      is_in :column1, [1,2]
      is_not_in :column2, [3, 4]
      exists 0
      not_exists 0
    end
    expected = "select column1, 'book', 10 from table1, table2
                  where column1 = 99 and column1 <> 100 and column2 < 'foo' 
                  and column3 <= column4 and column1 > 0 and column2 >= 'bar' 
                  and column1 is not null and column1 in (1, 2) and column2 not in (3, 4) 
                  and exists (0) and not exists (0)"
    assert_equal expected.delete("\n").squeeze(" "), statement.to_sql
  end
  
  def test_select_with_receive_any_objects_and_operators
    statement = Select[:column1, 'book', 10].from[:table1, :table2].where do
      table1.column1 = 99
      column1 <=> 100
      column2 < 'foo'
      column3 <= column4
      column1 > 0
      column2 >= 'bar'
      column1 ^ nil
      column1 >> [1,2]
      column2 << [3, 4]
    end
    expected = "select column1, 'book', 10 from table1, table2
                  where table1.column1 = 99 and column1 <> 100 and column2 < 'foo' 
                  and column3 <= column4 and column1 > 0 and column2 >= 'bar' 
                  and column1 is not null and column1 in (1, 2) and column2 not in (3, 4)"
    assert_equal expected.delete("\n").squeeze(" "), statement.to_sql
  end
  
  def test_select_with_receive_any_objects_and_method_calls
    statement = Select[:column1, 'book', 10].from[:table1, :table2].where do
      column1.equal 99
      column1.not_equal 100
      column2.less_than 'foo'
      column3.less_than_or_equal column4
      column1.greater_than 0
      column2.greater_than_or_equal 'bar'
      column1.is_not_null
      column1.is_in [1,2]
      column2.is_not_in [3, 4]
    end
    expected = "select column1, 'book', 10 from table1, table2
                  where column1 = 99 and column1 <> 100 and column2 < 'foo' 
                  and column3 <= column4 and column1 > 0 and column2 >= 'bar' 
                  and column1 is not null and column1 in (1, 2) and column2 not in (3, 4)"
    assert_equal expected.delete("\n").squeeze(" "), statement.to_sql
  end
  
  def test_select_with_receive_any_objects_and_method_calls
    statement = Select[:column1, 'book', 10].from[:table1, :table2].where do
      column1.equal 0
    end.or do
      column1 > 100
    end
    expected = "select column1, 'book', 10 from table1, table2 where column1 = 0 or (column1 > 100)"
    assert_equal expected, statement.to_sql
  end
  
  def test_columns_in_inner_where_are_validated_against_outer_tables
    statement = Select.all.from[:table].where do
      exists(Select.all.from[:inner_table => :aliased].where do
        table.column1 = aliased.column1
      end)
    end
    assert_equal 'select * from table where exists (select * from inner_table aliased where table.column1 = aliased.column1)', statement.to_sql
  end

  def test_columns_in_where_are_validated_against_tables
    assert_raises ArgumentError do
      Select.all.from[:table].where do
        not_table.cat = 12
      end
    end
  end

  def test_columns_in_inner_where_are_validated_against_outer_and_inner_tables
    assert_raises ArgumentError do
      Select.all.from[:table].where do
        exists(Select.all.from[:inner_table].where do
          table.column1 = not_table.cat
        end)
      end
    end
  end
end
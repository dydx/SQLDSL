def test_columns_in_inner_where_are_validated_against_outer_tables
  statement = Select.all.from[:table].where do
    exists(Select.all.from[:inner_table].where do
      table.column1 = inner_table.column1
    end)
  end
  assert_equal 'select * from table where exists (select * from inner_table where table.column1 = inner_table.column1)', statement.to_sql
end

def test_columns_in_where_are_validated_against_tables
  assert_raises RuntimeError do
    Select.all.from[:table].where do
      not_table.cat = 12
    end
  end
end

def test_columns_in_inner_where_are_validated_against_outer_and_inner_tables
  assert_raises RuntimeError do
    Select.all.from[:table].where do
      exists(Select.all.from[:inner_table].where do
        table.column1 = not_table.cat
      end)
    end
  end
end

require File.dirname(__FILE__) + '/test_helper'

class ReceiveAnyTest < Test::Unit::TestCase
  
  def test_single_equal_where_criteria
    statement = WhereBuilder.new [] do
      equal :column1, :column2
    end
    assert_equal ' where column1 = column2', statement.to_sql
  end
  
  def test_not_equal
    statement = WhereBuilder.new [] do
      not_equal :column1, :column2
    end
    assert_equal " where column1 <> column2", statement.to_sql
  end

  def test_is_in_array
    statement = WhereBuilder.new [] do
      is_in :column1, [1,2]
    end
    assert_equal " where column1 in (1, 2)", statement.to_sql
  end

  def test_is_not_in_where_criteria
    statement = WhereBuilder.new [] do
      is_not_in :column1, [1,2]
    end
    assert_equal ' where column1 not in (1, 2)', statement.to_sql
  end

  def test_less_than
    statement = WhereBuilder.new [] do
      less_than :column1, :column2
    end
    assert_equal " where column1 < column2", statement.to_sql
  end
  
  def test_less_than_or_equal
    statement = WhereBuilder.new [] do
      less_than_or_equal :column1, :column2
    end
    assert_equal " where column1 <= column2", statement.to_sql
  end

  def test_greater_than
    statement = WhereBuilder.new [] do
      greater_than :column1, :column2
    end
    assert_equal " where column1 > column2", statement.to_sql
  end
  
  def test_greater_than_or_equal
    statement = WhereBuilder.new [] do
      greater_than_or_equal :column1, :column2
    end
    assert_equal " where column1 >= column2", statement.to_sql
  end
  
  def test_where_clause_is_built_with_multiple_conditions
    statement = WhereBuilder.new [] do
      equal :column1, :column2
      equal :column3, :column5
    end
    expected = " where column1 = column2 and column3 = column5"
    assert_equal expected, statement.to_sql
  end
  
  def test_exists_evaluates_sql_statement_argument
    statement = WhereBuilder.new [] do
      exists Struct.new(:to_sql).new('select foo')
    end
    assert_equal ' where exists (select foo)', statement.to_sql
  end
  
  def test_not_exists_evaluates_sql_statement_argument
    statement = WhereBuilder.new [] do
      not_exists Struct.new(:to_sql).new('select foo')
    end
    assert_equal ' where not exists (select foo)', statement.to_sql
  end
  
  def test_is_not_null_where_criteria
    statement = WhereBuilder.new [] do
      not_null :something
    end
    assert_equal ' where something is not null', statement.to_sql
  end
end
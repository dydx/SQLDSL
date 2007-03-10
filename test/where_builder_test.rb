require File.dirname(__FILE__) + '/test_helper'

class WhereBuilderTest < Test::Unit::TestCase
  
  def test_condition_calls_to_sql
    lval, rval = mock, mock
    lval.expects(:to_sql)
    rval.expects(:to_sql)
    WhereBuilder.new([], &lambda {}).condition(lval, "", rval)
  end
  
  def test_equal
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
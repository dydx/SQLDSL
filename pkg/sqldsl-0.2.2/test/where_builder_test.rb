require File.dirname(__FILE__) + '/test_helper'

class WhereBuilderTest < Test::Unit::TestCase
  
  def test_single_equal_where_criteria
    statement = WhereBuilder.new do
      equal :'foo.column1', :'bar.column2'
    end
    assert_equal ' where foo.column1 = bar.column2', statement.to_sql
  end
  
  def test_single_equal_with_array_where_criteria
    statement = WhereBuilder.new do
      equal :'foo.column1', ['foo','bar']
    end
    assert_equal " where foo.column1 in ('foo', 'bar')", statement.to_sql
  end

  def test_multiple_equal_with_more_than_one_where_criteria
    statement = WhereBuilder.new do
      equal :'foo.column1', :'bar.column2'
      equal :'foo.column3', :'bar.column5'
    end
    expected = " where foo.column1 = bar.column2 and foo.column3 = bar.column5"
    assert_equal expected, statement.to_sql
  end
  
  def test_with_literal_where_criteria
    statement = WhereBuilder.new do
      equal 'foo.column1', :'bar.column2'
      equal :'foo.column3', 'bar.column5'
    end
    expected = " where 'foo.column1' = bar.column2 and foo.column3 = 'bar.column5'"
    assert_equal expected, statement.to_sql
  end
  
  def test_exists_evaluates_sql_statement_followed
    statement = WhereBuilder.new do
      exists Struct.new(:to_sql).new('select foo')
    end
    assert_equal ' where exists (select foo)', statement.to_sql
  end
  
  def test_not_exists_evaluates_sql_statement_followed
    statement = WhereBuilder.new do
      not_exists Struct.new(:to_sql).new('select foo')
    end
    assert_equal ' where not exists (select foo)', statement.to_sql
  end
end

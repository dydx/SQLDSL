require File.dirname(__FILE__) + '/test_helper'

class WhereBuilderTest < Test::Unit::TestCase
  
  def test_single_equal_where_criteria
    statement = WhereBuilder.new [:foo, :bar] do
      equal :'foo.column1', :'bar.column2'
    end
    assert_equal ' where foo.column1 = bar.column2', statement.to_sql
  end

  def test_less_then_equal_where_criteria
    statement = WhereBuilder.new [] do
      column1 <= column2
    end
    assert_equal " where column1 <= column2", statement.to_sql
  end

  def test_less_then_equal_with_table_aliasing_where_criteria
    statement = WhereBuilder.new [:table1, :table2] do
      table1.column1 <= table2.column2
    end
    assert_equal " where table1.column1 <= table2.column2", statement.to_sql
  end
  
  def test_equal_with_table_aliasing_where_criteria
    statement = WhereBuilder.new [:table1, :table2] do
      table1.Column1 = table2.Folumn2
    end
    assert_equal " where table1.Column1 = table2.Folumn2", statement.to_sql
  end

  def test_equal_with_a_numeric
    statement = WhereBuilder.new [:table1] do
      table1.Column1 = 1
    end
    assert_equal " where table1.Column1 = 1", statement.to_sql
  end

  def test_equal_with_a_string
    statement = WhereBuilder.new [:table1] do
      table1.Column1 = "foo"
    end
    assert_equal " where table1.Column1 = 'foo'", statement.to_sql
  end

  def test_single_equal_with_array_where_criteria
    statement = WhereBuilder.new([:foo]) do
      equal :'foo.column1', ['foo','bar']
    end
    assert_equal " where foo.column1 in ('foo', 'bar')", statement.to_sql
  end

  def test_multiple_equal_with_more_than_one_where_criteria
    statement = WhereBuilder.new [:foo, :bar] do
      equal :'foo.column1', :'bar.column2'
      equal :'foo.column3', :'bar.column5'
    end
    expected = " where foo.column1 = bar.column2 and foo.column3 = bar.column5"
    assert_equal expected, statement.to_sql
  end
  
  def test_with_literal_where_criteria
    statement = WhereBuilder.new([:foo, :bar]) do
      equal 'foo.column1', :'bar.column2'
      equal :'foo.column3', 'bar.column5'
    end
    expected = " where 'foo.column1' = bar.column2 and foo.column3 = 'bar.column5'"
    assert_equal expected, statement.to_sql
  end
  
  def test_exists_evaluates_sql_statement_followed
    statement = WhereBuilder.new [] do
      exists Struct.new(:to_sql).new('select foo')
    end
    assert_equal ' where exists (select foo)', statement.to_sql
  end
  
  def test_not_exists_evaluates_sql_statement_followed
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
  
  def test_is_not_in_where_criteria
    statement = WhereBuilder.new [] do
      :column1.is_not_in do
        Select[:shipment_option_id]
      end
    end
    assert_equal ' where column1 not in (select shipment_option_id)', statement.to_sql
  end
  
  def test_columns_in_where_are_validated_against_tables
    assert_raises RuntimeError do
      Select.all.from[:table].where do
        not_table.cat = 12
      end
    end
  end
end

require File.dirname(__FILE__) + '/test_helper'

class ObjectTest < Test::Unit::TestCase 

  def test_to_sql_equal
    assert_equal "column1 = foo", foo.to_sql_equal(:column1)
  end  
  
  def test_to_sql_more_than
    assert_equal "column1 > foo", foo.to_sql_more_than(:column1)
  end
  
  def test_to_sql_less_than
    assert_equal "column1 < foo", foo.to_sql_less_than(:column1)
  end
  
  def test_to_sql_less_than_equal
    assert_equal "column1 <= foo", foo.to_sql_less_than_or_equal_to(:column1)
  end
  
  def test_to_sql_more_than_equal
    assert_equal "column1 >= foo", foo.to_sql_more_than_or_equal_to(:column1)
  end
  
  def foo
    Struct.new(:to_sql).new(:foo)
  end

end 

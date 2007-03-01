require File.dirname(__FILE__) + '/test_helper'

class NumbericTest < Test::Unit::TestCase 
  def test_to_sql_gives_self
    assert_equal 123, 123.to_sql
  end

  def test_is_a_where_value_duck
    assert_equal true, 123.respond_to?(:is_not_in)
  end
  
end
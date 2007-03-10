require File.dirname(__FILE__) + '/test_helper'

class NumbericTest < Test::Unit::TestCase 
  def test_to_sql_gives_self
    assert_equal 123, 123.to_sql
  end
end
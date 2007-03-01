require File.dirname(__FILE__) + '/test_helper'

class HashTest < Test::Unit::TestCase 

  def test_to_sql_name_value_as_aliasing
    assert_equal "a as b, c as d", {:a => :b, :c => :d}.to_sql
  end
  
end
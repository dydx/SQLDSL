require File.dirname(__FILE__) + '/test_helper'

class ArrayTest < Test::Unit::TestCase 
  def test_to_sql_gives_of_to_sql_objects_comma_delimited
    assert_equal "too, 'the', 2", [:too, 'the', 2].to_sql
  end
end
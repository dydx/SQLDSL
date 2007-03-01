require File.dirname(__FILE__) + '/test_helper'

class StringTest < Test::Unit::TestCase 
  def test_to_sql_gives_quoted
    assert_equal "'123'", "123".to_sql
  end

  def test_to_sql_gives_quoted_and_escapes_single_quotes
    assert_equal "'it''s'", "it's".to_sql
  end
  
  def test_is_a_where_value_duck
    assert_equal true, "foo".respond_to?(:is_not_in)
  end
  
end
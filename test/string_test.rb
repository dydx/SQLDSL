require File.dirname(__FILE__) + '/test_helper'

class StringTest < Test::Unit::TestCase 
  def test_to_sql_gives_quoted
    assert_equal "'123'", "123".to_sql
  end

  def test_to_sql_gives_quoted_and_escapes_single_quotes
    assert_equal "'it''s'", "it's".to_sql
  end
  
  def test_as
    assert_equal :"'foo' as bar", "foo".as(:bar)
  end
end
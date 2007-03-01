require File.dirname(__FILE__) + '/test_helper'

class SymbolTest < Test::Unit::TestCase 
  def test_to_sql_returns_to_s
    assert_equal 'asdf', :asdf.to_sql
  end
  
  def test_is_a_where_value_duck
    assert_equal true, :sym.respond_to?(:is_not_in)
  end
  
end
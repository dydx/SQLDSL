require File.dirname(__FILE__) + '/test_helper'

class SymbolTest < Test::Unit::TestCase 
  def test_to_sql_returns_to_s
    assert_equal 'asdf', :asdf.to_sql
  end
  
  def test_as
    assert_equal 'asdf as bam', :asdf.as(:bam)
  end
end
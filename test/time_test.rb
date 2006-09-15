require File.dirname(__FILE__) + '/test_helper'

class TimeTest < Test::Unit::TestCase 
  def test_to_sql_gives_quoted
    t = Time.at(946702800)
    assert_equal "to_timestamp('2000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')", t.to_sql
  end
end 

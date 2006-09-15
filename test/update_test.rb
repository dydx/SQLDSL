require File.dirname(__FILE__) + '/test_helper'

class UpdateTest < Test::Unit::TestCase

  def test_update_takes_a_table_name
    assert_equal "update account_info", Update[:account_info].to_sql
  end

  def test_update_set_appends_hash_values
    assert_equal "update account_info set bar='cat', foo=1", Update[:account_info].set[:foo=>1, :bar=> 'cat'].to_sql
  end

end

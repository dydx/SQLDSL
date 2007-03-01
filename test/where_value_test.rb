require File.dirname(__FILE__) + '/test_helper'

class WhereValueTest < Test::Unit::TestCase
  
  def test_not_in_sql_statement_with_value
    klass = Class.new() do
      include WhereValue
      
      def to_sql
        "klass"
      end
    end
    
    statement = Select[:foo].where do
      klass.new.is_not_in do
        "anything"
      end
    end
    assert_equal "select foo where klass not in ('anything')", statement.to_sql
  end
  
end

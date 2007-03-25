require File.dirname(__FILE__) + '/test_helper'

class ReceiveAnyTest < Test::Unit::TestCase

  def test_method_calls_to_valid_table_names_are_okay
    builder = stub(:tables => [:foo])
    ReceiveAny.new(:foo, builder).column1
  end
  
  def test_method_calls_to_invalid_table_names_raise_Argument_Error
    assert_raises ArgumentError do
      builder = stub(:tables => [])
      ReceiveAny.new(:foo, builder).column1
    end
  end
  
  def test_equal
    builder = mock
    builder.expects(:equal).with do |lval, rval|
      lval.class == ReceiveAny && rval == 1
    end
    ReceiveAny.new(:foo, builder).equal 1
  end
  
  def test_equal_operator
    builder = mock
    builder.expects(:equal).with do |lval, rval|
      lval.class == ReceiveAny && rval == 1
    end
    ReceiveAny.new(:foo, builder) == 1
  end
  
  def test_not_equal
    builder = mock
    builder.expects(:not_equal).with do |lval, rval|
      lval.class == ReceiveAny && rval == 1
    end
    ReceiveAny.new(:foo, builder).not_equal 1
  end
  
  def test_not_equal_operator
    builder = mock
    builder.expects(:equal).with do |lval, rval|
      lval.class == ReceiveAny && rval == 1
    end
    ReceiveAny.new(:foo, builder) <=> 1
  end
  
  def test_less_than
    builder = mock
    builder.expects(:less_than).with do |lval, rval|
      lval.class == ReceiveAny && rval == 1
    end
    ReceiveAny.new(:foo, builder).less_than 1
  end
  
  def test_less_than_operator
    builder = mock
    builder.expects(:less_than).with do |lval, rval|
      lval.class == ReceiveAny && rval == 1
    end
    ReceiveAny.new(:foo, builder) < 1
  end
  
  def test_less_than_or_equal
    builder = mock
    builder.expects(:less_than_or_equal).with do |lval, rval|
      lval.class == ReceiveAny && rval == 1
    end
    ReceiveAny.new(:foo, builder).less_than_or_equal 1
  end
  
  def test_less_than_or_equal_operator
    builder = mock
    builder.expects(:less_than_or_equal).with do |lval, rval|
      lval.class == ReceiveAny && rval == 1
    end
    ReceiveAny.new(:foo, builder) <= 1
  end
  
  def test_greater_than
    builder = mock
    builder.expects(:greater_than).with do |lval, rval|
      lval.class == ReceiveAny && rval == 1
    end
    ReceiveAny.new(:foo, builder).greater_than 1
  end
  
  def test_greater_than_operator
    builder = mock
    builder.expects(:greater_than).with do |lval, rval|
      lval.class == ReceiveAny && rval == 1
    end
    ReceiveAny.new(:foo, builder) > 1
  end
  
  def test_greater_than_or_equal
    builder = mock
    builder.expects(:greater_than_or_equal).with do |lval, rval|
      lval.class == ReceiveAny && rval == 1
    end
    ReceiveAny.new(:foo, builder).greater_than_or_equal 1
  end
  
  def test_greater_than_or_equal_operator
    builder = mock
    builder.expects(:greater_than_or_equal).with do |lval, rval|
      lval.class == ReceiveAny && rval == 1
    end
    ReceiveAny.new(:foo, builder) >= 1
  end
  
  def test_is_in
    builder = mock
    builder.expects(:is_in).with do |lval, rval|
      lval.class == ReceiveAny && rval == [1,2]
    end
    ReceiveAny.new(:foo, builder).is_in [1,2]
  end

  def test_is_in_operator
    builder = mock
    builder.expects(:is_in).with do |lval, rval|
      lval.class == ReceiveAny && rval == [1,2]
    end
    ReceiveAny.new(:foo, builder) >> [1,2]
  end

  def test_is_not_in
    builder = mock
    builder.expects(:is_not_in).with do |lval, rval|
      lval.class == ReceiveAny && rval == [1,2]
    end
    ReceiveAny.new(:foo, builder).is_not_in [1,2]
  end

  def test_is_not_in_operator
    builder = mock
    builder.expects(:is_not_in).with do |lval, rval|
      lval.class == ReceiveAny && rval == [1,2]
    end
    ReceiveAny.new(:foo, builder) << [1,2]
  end

  def test_is_not_null
    builder = mock
    builder.expects(:is_not_null).with do |lval|
      lval.class == ReceiveAny
    end
    ReceiveAny.new(:foo, builder).is_not_null
  end

  def test_is_not_null_operator
    builder = mock
    builder.expects(:is_not_in).with do |lval|
      lval.class == ReceiveAny
    end
    ReceiveAny.new(:foo, builder) ^ nil
  end
  
  def test_like
    builder = mock
    builder.expects(:like).with do |lval, rval|
      lval.class == ReceiveAny && rval == "any"
    end
    ReceiveAny.new(:foo, builder).like "any"
  end

  def test_like
    builder = mock
    builder.expects(:like).with do |lval, rval|
      lval.class == ReceiveAny && rval == "any"
    end
    ReceiveAny.new(:foo, builder) =~ "any"
  end
end
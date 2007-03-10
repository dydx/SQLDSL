require 'test/unit'
unless File.directory? File.dirname(__FILE__) + '/../vendor/mocha-0.4.0/'
  raise "mocha 4.0 is required to run the test suite. create the 'vendor' directory as a sibling of test and 'gem unpack mocha' in 'vendor'"
end
$:.unshift File.dirname(__FILE__) + '/../vendor/mocha-0.4.0/lib/'
require File.dirname(__FILE__) + '/../vendor/mocha-0.4.0/lib/mocha'
require File.dirname(__FILE__) + '/../lib/sqldsl'
task :default do
  Dir['**/*_test.rb'].each { |testCase| require testCase }
end
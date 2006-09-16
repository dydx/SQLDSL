require 'rubygems'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/contrib/sshpublisher'

task :default do
  Dir['**/*_test.rb'].each { |testCase| require testCase }
end

Gem::manage_gems 

specification = Gem::Specification.new do |s| 
  s.name = "sqldsl"
  s.version = "0.1"
  s.author = "Jay Fields"
  s.email = "sqldsl-developer@rubyforge.org"
  s.homepage = "sqldsl.rubyforge.org"
  s.rubyforge_project = 'sqldsl'
  s.platform = Gem::Platform::RUBY
  s.summary = "A DSL for creating SQL Statements"

  s.files = FileList["lib/**/*"].to_a
  s.require_path = "lib"
  s.autorequire = "sqldsl"
  s.test_files = FileList["test/**/*test.rb"].to_a
  
  s.has_rdoc = true
  s.extra_rdoc_files = ["README"]
  s.rdoc_options << '--title' << 'SQL DSL' << '--main' << 'README' << '--line-numbers'
end

Rake::GemPackageTask.new(specification) do |package|
	 package.need_zip = true
	 package.need_tar = true
end

desc 'Generate RDoc'
Rake::RDocTask.new do |task|
  task.main = 'README'
  task.title = 'SQL DSL'
  task.rdoc_dir = 'doc'
  task.options << "--line-numbers" << "--inline-source"
  task.rdoc_files.include('README', 'lib/**/*.rb')
  %x[erb README_TEMPLATE > README]
end

desc "Upload RDoc to RubyForge"
task :publish_rdoc => [:rdoc] do
  Rake::SshDirPublisher.new("jaycfields@rubyforge.org", "/var/www/gforge-projects/sqldsl", "doc").upload
end

require 'rubygems'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/contrib/sshpublisher'

task :default do
  require File.dirname(__FILE__) + '/test/all_tests.rb'  
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

Gem::manage_gems

specification = Gem::Specification.new do |s|
	s.name   = "sqldsl"
  s.summary = "A DSL for creating SQL Statements"
	s.version = "1.3.1"
	s.author = 'Jay Fields'
	s.description = "A DSL for creating SQL Statements"
	s.email = 'sqldsl-developer@rubyforge.org'
  s.homepage = 'http://sqldsl.rubyforge.org'
  s.rubyforge_project = 'sqldsl'

  s.has_rdoc = true
  s.extra_rdoc_files = ['README']
  s.rdoc_options << '--title' << 'SQL DSL' << '--main' << 'README' << '--line-numbers'
                         
  s.autorequire = 'sqldsl'
  s.files = FileList['{lib,test}/**/*.rb', '[A-Z]*$', 'rakefile.rb'].to_a
	s.test_file = "test/all_tests.rb"
end

Rake::GemPackageTask.new(specification) do |package|
	 package.need_zip = false
	 package.need_tar = false
end

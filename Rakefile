require 'rubygems'
require 'rake'

require 'lib/ramazon_advertising'
load File.join(File.dirname(__FILE__), 'lib', 'tasks', 'ramazon.rake')

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "ramazon_advertising"
    gem.summary = %Q{TODO: one-line summary of your gem}
    gem.description = %Q{TODO: longer description of your gem}
    gem.email = "dpickett@enlightsolutions.com"
    gem.homepage = "http://github.com/dpickett/ramazon_advertising"
    gem.authors = ["Dan Pickett"]
    gem.add_dependency("jnunemaker-httparty", ">= 0.4.3")
    gem.add_dependency("jnunemaker-happymapper", ">= 0.2.5")
    gem.add_dependency("mislav-will_paginate", ">= 2.3.11")
    gem.add_dependency("nokogiri", ">= 1.3.3")
    gem.add_dependency("configatron", ">= 2.4.1")   
    gem.add_dependency("ruby-hmac", ">= 0.3.2")
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:cucumber)
rescue LoadError
  task :cucumber do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ramazon_advertising #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require "YARD"
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  YARD::Rake::YardocTask.new do |t|
  end
rescue LoadError

end



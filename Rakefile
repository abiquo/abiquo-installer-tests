require 'rubygems'

require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.version = Time.now.strftime "%Y%m%d.3"
  gem.name = "abiquo-installer-tests"
  gem.homepage = "http://github.com/abiquo/abiquo-installer-tests"
  gem.license = "MIT"
  gem.summary = %Q{Abiquo Installer Unit Tests}
  gem.description = %Q{Tests and troubleshoot Abiquo installations}
  gem.email = "abel.boldu@abiquo.com"
  gem.authors = ["Sergio Rubio","Abel Boldu"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  gem.add_runtime_dependency 'term-ansicolor', '>= 1.0'
  # gem.add_runtime_dependency 'net-ssh', '>= 2.0'
  # gem.add_runtime_dependency 'net-scp', '>= 1.0'
  # gem.add_runtime_dependency 'net-sftp', '>= 2.0'
  gem.add_runtime_dependency 'iniparse', '>= 1.0'
  gem.add_runtime_dependency 'mixlib-cli', '>= 1.2'
  gem.files.include %w(
      lib/
      vendor/**/*
      tests/**/*
  )
end
Jeweler::RubygemsDotOrgTasks.new


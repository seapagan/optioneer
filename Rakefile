require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'inch/rake'

RSpec::Core::RakeTask.new(:spec)

# rubocop is not compatible with Ruby < 2.0
if RUBY_VERSION >= '2.0'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |task|
    task.options << 'lib'
    task.fail_on_error = false
  end
else
  task :rubocop do
    # Empty task
  end
end

Inch::Rake::Suggest.new do |suggest|
  suggest.args << '--pedantic'
end

# reek is not comp[atible with Ruby < 2.0]
if RUBY_VERSION > '2.0'
  require 'reek/rake/task'
  Reek::Rake::Task.new do |t|
    t.fail_on_error = false
    t.verbose       = true
    t.reek_opts     = '-U'
  end
else
  task :reek do
    # Empty task
  end
end

# Auto running of the below tasks are currently disabled until the project is a
# little more mature and proper documentation can begin. They can still be run
# manually though :
# :reek
task default: [:rubocop, :inch, :spec, :build]

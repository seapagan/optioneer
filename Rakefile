require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'inch/rake'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new do |task|
  task.options << 'lib'
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
# :rubocop
# :inch
# :reek
task default: [:rubocop, :inch, :spec, :build]

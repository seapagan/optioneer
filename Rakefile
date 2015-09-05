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

# task :inch currently disabled until project is a little more mature and proper
# documentation can begin
# task :rubocop also currently disabled
task default: [:spec]

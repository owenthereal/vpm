module VPM::Commands::Setup::Tasks ; end

this_directory  = File.expand_path File.dirname(__FILE__)
tasks_directory = File.join(this_directory, "tasks")

require File.join(tasks_directory, "create_directory.rb")
Dir.glob(File.join(tasks_directory, "**", "*.rb")).each do |filename|
  require filename
end

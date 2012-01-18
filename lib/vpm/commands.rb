module Commands
  def self.[](command)
    if command.empty?
      InstallAllPlugins
    elsif self.const_defined?(command)
      self.const_get(command).new
    else
      InvalidCommand.new(command)
    end
  end
end

this_directory     = File.expand_path File.dirname(__FILE__)
commands_directory = File.join(this_directory, "commands")

Dir.glob(File.join(commands_directory, "**", "*.rb")).each do |filename|
  require filename
end

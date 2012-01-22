module VPM
  module CommandOptions
    def self.[](command)
      command = command.capitalize

      if self.const_defined?(command)
        self.const_get(command).new
      else
        Empty.new
      end
    end
  end
end

this_directory = File.expand_path File.dirname(__FILE__)
command_options_directory = File.join(this_directory, "command_options")

Dir.glob(File.join(command_options_directory, "*.rb")).each do |filename|
  require filename
end

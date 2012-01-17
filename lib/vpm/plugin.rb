module VPM
  class Plugin
    attr_reader :name, :type, :options

    def initialize(name, type, options = {})
      @name = name
      @type = type
      @options = options
    end

    def run_command(command)
      if command == "install"
        Commands::Install.run!(name, type, options)
      end
    end

    ["install", "update"].each do |cmd|
      define_method(cmd) do
        run_command(cmd)
      end
    end
  end
end

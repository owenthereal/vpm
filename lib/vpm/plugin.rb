module VPM
  class Plugin
    attr_reader :name, :options

    def initialize(name, options = {})
      @name = name
      @options = options
    end

    def run_command(command)
      if command == "install"
        Commands::Install.run!(name, options)
      end
    end

    ["install", "update"].each do |cmd|
      define_method(cmd) do
        run_command(cmd)
      end
    end
  end
end

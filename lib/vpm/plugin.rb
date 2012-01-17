module VPM
  class Plugin
    def self.from_hash(hash)
      self.new(hash[:name], hash[:type], hash[:options])
    end

    attr_reader :name, :type, :options

    def initialize(name, type, options = {})
      @name = name
      @type = type
      @options = options
    end

    def run_command(command)
      result = false
      plugins = VPM.plugins
      if command == "install"
        result = Commands::Install.run(name, type, options) unless plugins.installed?(name)
        plugins.plugin_installed(self) if result
      end

      result
    end

    ["install", "update", "remove"].each do |cmd|
      define_method(cmd) do
        run_command(cmd)
      end
    end

    def to_hash
      {
        :name => name,
        :type => type,
        :options => options
      }
    end
  end
end

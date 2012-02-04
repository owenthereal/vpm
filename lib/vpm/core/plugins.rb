require 'yaml'

module VPM::Core
  class Plugins
    attr_reader :all, :installed_plugins, :removed_plugins

    def initialize
      @all = []
      @installed_plugins = []
      @removed_plugins = []
    end

    def find(plugin_name)

    end

    def installed?(plugin_name)
      all.find { |p| p.name == plugin_name }
    end

    def changed?
      installed_plugins.any? || removed_plugins.any?
    end

    def plugin_installed(plugin)
      all << plugin
      installed_plugins << plugin
    end

    def plugin_removed(plugin)
      all.delete(plugin)
      removed_plugins << plugin
    end

    def load(content)
      deserialized_content = YAML::load(content)
      @all = deserialized_content ? deserialized_content.collect { |hash| Plugin.from_hash(hash) } : []
    end

    def dump(io = nil)
      YAML.dump(@all.collect(&:to_hash), io)
    end

    def self.load_from_file(file_path)
      plugins = self.new
      File.open(file_path) do |f|
        plugins.load(f)
      end

      plugins
    end

    def save_to_file(file_path = VPM.plugins_file)
      File.open(file_path, 'w' ) do |out|
        dump(out)
      end
    end
  end
end

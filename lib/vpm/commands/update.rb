module VPM
  module Commands
    module Update
      def self.call(options = {})
        plugin_names = options.fetch(:plugin_names) { VPM.plugins.map &:name }
        plugin_names.each { |name| update_plugin name }
      end

      def self.update_plugin(plugin_name)
        plugin = VPM.plugins.find plugin_name
        send(:"update_#{plugin.type}_plugin", plugin)
      end

      def self.update_git_plugin(plugin)
        plugin_dir = File.join(VPM.bundle_dir_path, plugin.name)
        Dir.chdir(plugin_dir) do
          if system("git pull origin master")
          end
        end
      end
    end
  end
end

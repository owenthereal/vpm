module VPM
  module Commands
    class Update
      def call(options = {})
        plugin_names = options.fetch(:plugin_names) { VPM.plugins.map &:name }
        plugin_names.each { |name| update_plugin name }
      end

      def update_plugin(plugin_name)
        VPM.plugins.do_to plugin_name do |plugin|
          send(:"update_#{plugin.type}_plugin", plugin)
        end
      end

      def update_git_plugin(plugin)
        plugin_dir = File.join(VPM.bundle_dir_path, plugin.name)
        Dir.chdir(plugin_dir) do
          puts "Failed to update #{plugin.name}" unless system("git pull origin master")
        end
      end
    end
  end
end

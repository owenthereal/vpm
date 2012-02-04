module VPM
  module Commands
    class Install
      def call(options = {})
        if options[:plugin_name]
          install_plugin(options)
        elsif File.exists?(VPM.vim_plugins_manifest_path)
          content = File.read(VPM.vim_plugins_manifest_path)
          plugins_options = VPM::Core::ManifestParser.parse(content)
          plugins_options.each do |options|
            install_plugin(options)
          end
        end
      end

      def install_plugin(options)
        plugin_name = options[:plugin_name]
        type = options[:type]

        return if plugin_name.nil? || type.nil? || VPM.plugins.installed?(plugin_name)

        plugin = VPM::Core::Plugin.new(plugin_name, type, options)
        result = if type == :git
                   GitInstall.run(plugin)
                 end

        VPM.plugins.plugin_installed(plugin) if result
      end

      module GitInstall
        def self.run(plugin)
          plugin_name = plugin.name
          options = plugin.options

          result = Dir.chdir(VPM.bundle_dir_path) do
            VPM::Utils::Git.clone(options[:remote], plugin_name) 
          end

          plugin_dir = File.join(VPM.bundle_dir_path, plugin_name)
          Dir.chdir(plugin_dir) do
            if options[:tag]
              result = VPM::Utils::Git.checkout_tag(options[:tag])
            end

            plugin.options[:revision] = VPM::Utils::Git.current_revision
          end

          result
        end
      end
    end
  end
end

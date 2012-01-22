module VPM
  module Commands
    module Install
      def self.call(options = nil)
        plugin = VPM::Core::Plugin.new(options[:plugin_name], options[:type], options[:options])
        type = plugin.type
        result = if type == :git
                   GitInstall.run(plugin)
                 end
        VPM.plugins.plugin_installed(self) if result
      end

      module GitInstall
        def self.run(plugin)
          plugin_name = plugin.name
          options = plugin.options

          chdir(VPM.bundle_dir_path) do
            result = VPM::Git.clone(options[:remote], plugin_name)

            chdir(File.join(VPM.plugin_dir, plugin_name)) do
              if options[:tag]
                result = VPM::Git.checkout_tag(options[:tag])
              end

              plugin.options[:revision] = VPM::Git.current_revision
            end

            result
          end
        end

        def self.chdir(dir)
          Dir.chdir(dir) { yield }
        end
      end
    end
  end
end

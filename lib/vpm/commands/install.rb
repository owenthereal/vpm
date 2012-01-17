module VPM
  module Commands
    module Install
      def self.run!(plugin_name, type, options)
        if type == :git
          GitInstall.run!(plugin_name, options)
        end
      end

      module GitInstall
        def self.run!(plugin_name, options)
          chdir(VPM.plugin_dir) do
            VPM::Git.clone(options[:remote], plugin_name)

            if options[:tag]
              chdir(File.join(VPM.plugin_dir, plugin_name)) do
                VPM::Git.checkout_tag(options[:tag]) 
              end
            end
          end
        end

        def self.chdir(dir)
          Dir.chdir(dir) { yield }
        end
      end
    end
  end
end

module VPM
  module CommandOptions
    class Update < Base
      def define_parser(parser, options)
        parser.banner = "Usage: vpm update [PLUGINS]"

        parser.on("[PLUGINS]") do |plugins|
          puts plugins
          options[:plugin_names] = plugins
        end
      end
    end
  end
end

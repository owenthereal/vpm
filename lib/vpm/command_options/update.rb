module VPM
  module CommandOptions
    class Update < Base
      def define_parser(parser, options)
        parser.banner = "Usage: vpm update [PLUGINS]"
        options[:plugin_names] = ARGV.clone if ARGV.any?
      end
    end
  end
end

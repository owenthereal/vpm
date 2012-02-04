module VPM
  module CommandOptions
    class Update < Base
      def define_parser(parser, options)
        parser.banner = "Usage: vpm update [plugin0, plugin1, ...]"
      end
    end
  end
end

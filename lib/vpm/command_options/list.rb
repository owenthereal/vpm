module VPM
  module CommandOptions
    class List < Base
      def define_parser(parser, options)
        parser.banner = "Usage: vpm list [plugin]"
      end
    end
  end
end

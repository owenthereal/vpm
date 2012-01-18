module VPM
  module CommandOptions
    class List < AbstractCommandOptions
      def define_parser(parser, options)
        parser.banner = "Usage: vpm list [plugin]"
      end
    end
  end
end

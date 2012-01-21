require 'optparse'

module VPM
  module CommandOptions
    class AbstractCommandOptions
      attr_reader :opts_parser

      def parse!(args)
        options = {}

        parser(options).parse!(args)
        options[:plugin_name] = args.shift

        options
      end

      def parser(options)
        @opts_parser ||= OptionParser.new do |parser|
          define_parser(parser, options)

          parser.on_tail("-h", "--help", "Show help") do |v|
            puts parser
            exit
          end
        end
      end
    end
  end
end

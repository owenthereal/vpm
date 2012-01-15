require 'optparse'

module VPM
  module Options
    module Install
      def self.parse!(args)
        options = {}
        parser(options).parse!(args)

        options
      end

      def self.parser(options)
        OptionParser.new do |parser|
          parser.banner = "Usage: vpm insatll <plugin> [options]"

          parser.on("-g", "--git [REMOTE]", "Install from a Git repository") do |git_url|
            options[:type] = :git
            options[:remote] = git_url
          end

          parser.on("-t", "--tag [TAG]", "Specify a tag for the Git repository") do |tag|
            options[:tag] = tag
          end

          parser.on_tail("-h", "--help", "Show help") do |v|
            puts parser
            exit
          end
        end
      end
    end
  end
end

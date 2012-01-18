module VPM
  module CommandOptions
    class Install < AbstractCommandOptions
      def define_parser(parser, options)
        parser.banner = "Usage: vpm install <plugin> [options]"

        parser.on("-g", "--git [REMOTE]", "Install from a Git repository") do |git_url|
          options[:type] = :git
          options[:remote] = git_url
        end

        parser.on("-t", "--tag [TAG]", "Specify a tag for the Git repository") do |tag|
          options[:tag] = tag
        end
      end
    end
  end
end

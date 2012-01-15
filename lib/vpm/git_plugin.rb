module VPM
  class GitPlugin < Plugin
    attr_accessor :git_commander

    def initialize(name, options)
      super
      git_commander = GitCommander
    end

    def install
      git_commander.clone(options[:git], VPM.plugin_dir)
    end

    module GitCommander
      def self.clone(repo, destination)
        Dir.chdir destination do
          `git clone #{repo}`
        end
      end
    end
  end
end

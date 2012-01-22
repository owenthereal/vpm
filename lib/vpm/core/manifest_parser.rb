module VPM::Core
  class ManifestParser
    def self.parse(content)
      self.new.parse(content)
    end

    def initialize
      @plugins = {}
    end

    def parse(content)
      instance_eval(content)
      plugins
    end

    def plugin(name, options = {})
      # FIXME hardcode to install for now
      options = VPM::CommandOptions["Install"].parse!(options_to_args(options))
      @plugins[name] = options
    end

    def options_to_args(options)
      args = []

      if options[:git]
        args += ["--git", options[:git]]
        args += ["--tag", options[:tag]] if options[:tag]
      end

      args
    end

    def plugins
      @plugins.values
    end
  end
end

module VPM
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
      options = VPM::Options.parse!("install", options_to_args(options))
      @plugins[name] = Plugin.new(name, options)
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
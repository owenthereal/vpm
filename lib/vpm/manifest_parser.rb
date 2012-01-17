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
      options = VPM::CommandOptions.parse!("install", options_to_args(options))
      type = options.delete(:type)
      @plugins[name] = Plugin.new(name, type, options)
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

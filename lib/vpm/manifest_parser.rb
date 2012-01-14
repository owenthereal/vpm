module VPM
  class ManifestParser
    def initialize
      @plugins = {}
    end

    def parse(content)
      instance_eval(content)
      plugins
    end

    def plugin(name, options = {})
      @plugins[name] = Plugin.create(name, options)
    end

    def plugins
      @plugins.values
    end
  end
end

module VPM
  class Plugin
    attr_reader :name, :options

    def initialize(name, options = {})
      @name = name
      @options = options
    end

    def self.create(name, options)
      if options.has_key?(:git)
        GitPlugin.new(name, options)
      end
    end
  end
end

module VPM
  module Runner
    def self.autorun
      return if installed_at_exit?
      at_exit { exit run(ARGV).to_i }
      @installed_at_exit = true
    end
    AT_EXIT_HOOK_BACKTRACE_LINE = "#{__FILE__}:#{__LINE__ - 2}:in `autorun'"

    def self.installed_at_exit?
      @installed_at_exit ||= false
    end

    def self.run(args)
      command = args[0]

      # TODO: extract out into CommandLine.run(args)
      result = false
      if command.nil?
        result = install_all_plugins
      else
        result = run_command(command, args)
      end

      result ? 0 : 1

    ensure
      VPM.plugins.save_to_file if VPM.plugins.changed?
    end

    # TODO: Make this part of `vpm install`
    def self.install_all_plugins
      vim_plugins_file = File.join(File.expand_path('.'), 'VimPlugins')
      content = File.read(vim_plugins_file)
      plugins = ManifestParser.parse(content)
      plugins.each(&:install)
      true
    end

    def self.run_command(command, args)
      parser = CommandOptions.parser(command)
      options = parser.parse!(args)

      plugin_name = args[1]
      unless plugin_name
        puts parser.opts_parser
        exit
      end

      type = options.delete(:type)
      plugin = Core::Plugin.new(plugin_name, type, options)
      plugin.run_command(command)
    end
  end
end

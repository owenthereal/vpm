module VPM
  module Runner
    def self.autorun
      return if installed_at_exit?
      at_exit { exit run(ARGV) }
      @installed_at_exit = true
    end
    AT_EXIT_HOOK_BACKTRACE_LINE = "#{__FILE__}:#{__LINE__ - 2}:in `autorun'"

    def self.installed_at_exit?
      @installed_at_exit ||= false
    end

    def self.run(args)
      command = args.shift
      run_command(command, args) ? 0 : 1
    ensure
      VPM.plugins.save_to_file if VPM.plugins.changed?
    end

    def self.run_command(command, args)
      options = VPM::CommandOptions[command].parse!(args)
      VPM::Commands[command].call options
    end
  end
end

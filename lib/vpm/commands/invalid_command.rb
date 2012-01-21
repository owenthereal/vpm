class VPM::Commands::InvalidCommand
  def initialize(invalid_command)
    @invalid_command = invalid_command
  end

  def call(args)
    puts "'#{@invalid_command}' is not a valid command."
    exit 1
  end
end

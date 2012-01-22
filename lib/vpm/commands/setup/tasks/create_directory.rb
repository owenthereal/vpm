class VPM::Commands::Setup::Tasks::CreateDirectory
  def initialize(directory)
    @destination = directory
  end

  def perform
    @dir_already_exists = Dir.exists? @destination
    return true if @dir_already_exists
    FileUtils.mkdir_p @destination
  end

  def undo
    return if @dir_already_exists
    FileUtils.rm_r @destination
  end
end

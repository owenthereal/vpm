class VPM::Commands::Setup::Tasks::CreateOurRCFile
  def initialize
    @destination = VPM.vpmrc_path
  end

  def perform
    File.open(@destination, "w") do |file|
      file.puts "call pathogen#infect()"
    end
    return true
  end

  def undo
    FileUtils.rm @destination
  end
end

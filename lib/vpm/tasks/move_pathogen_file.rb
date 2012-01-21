class MovePathogenFile
  def initialize(base_dir)
    @source_file = File.join(base_dir, "pathogen", "autoload", "pathogen.vim")
    @destination = File.join(VPM.vim_dir_path, "autoload", "pathogen.vim")
  end

  def perform
    @file_already_exists = File.exists? @destination
    return true if @file_already_exists
    FileUtils.mv(@source_file, @destination)
  end

  def undo
    return if @file_already_exists
    FileUtils.rm @destination
  end
end

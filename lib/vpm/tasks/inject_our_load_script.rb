class InjectOurLoadScript
  def initialize(backup_dir)
    @text          = "source #{VPM.vpmrc_path}"
    @backup_path = File.join(backup_dir, "vimrc_backup_#{Time.now.to_i}")
  end

  def perform
    FileUtils.touch VPM.vimrc_path
    create_file unless File.read(VPM.vimrc_path).include? @text
    return true
  end

  def undo
    FileUtils.cp(@backup_path, VPM.vimrc_path)
  end

private

  def create_file
    FileUtils.cp(VPM.vimrc_path, @backup_path)
    File.open(VPM.vimrc_path, "w") do |file|
      file.puts @text
      File.open(@backup_path, "r").each_line do |old_vimrc|
        file.puts old_vimrc
      end
    end
  end
end

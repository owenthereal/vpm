class CreateAutoloadDir < CreateDirectory
  def initialize
    super File.join(VPM.vim_dir_path, "autoload")
  end
end

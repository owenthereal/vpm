class ClonePathogen
  def initialize(base_dir)
    @destination = File.join(base_dir, 'pathogen')
  end

  def perform
    Kernel.system "git clone https://github.com/tpope/vim-pathogen.git #{@destination}"
  end

  def undo
    FileUtils.rm_r @destination
  end
end

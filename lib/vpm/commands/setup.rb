class VPM::Commands::Setup
  attr_accessor :pathogen_cloner
  attr_accessor :bundle_dir_creator
  attr_accessor :autoload_dir_creator
  attr_accessor :pathogen_file_mover
  attr_accessor :rc_file_creator
  attr_accessor :rc_file_injector

  def initialize
     self.pathogen_cloner      = ClonePathogen
     self.bundle_dir_creator   = CreateBundleDir
     self.autoload_dir_creator = CreateAutoloadDir
     self.pathogen_file_mover  = MovePathogenFile
     self.rc_file_creator      = CreateOurRCFile
     self.rc_file_injector     = InjectOurLoadScript
  end

  def call(args = nil)
    install_pathogen unless pathogen_installed?
    create_vpmrc
    inject_vimrc     unless vimrc_setup?
  end

private

  def install_pathogen
    Dir.mktmpdir do |dir|
      transaction = Transaction.new
      transaction << pathogen_cloner.new(dir)
      transaction << bundle_dir_creator.new
      transaction << autoload_dir_creator.new
      transaction << pathogen_file_mover.new(dir)
      transaction.perform
    end
  end

  def create_vpmrc
    transaction = Transaction.new
    transaction << rc_file_creator.new
    transaction.perform
  end

  def inject_vimrc
    Dir.mktmpdir do |dir|
      transaction = Transaction.new
      transaction << rc_file_injector.new(dir)
      transaction.perform
    end
  end

  def pathogen_installed?
    plugin_directory = VPM.bundle_dir
    pathogen_file    = File.join(VPM.vim_dir_path, 'autoload', 'pathogen.vim')
    Dir.exists?(plugin_directory) && File.exists?(pathogen_file)
  end

  def vimrc_setup?
    FileUtils.touch VPM.vimrc_path
    File.open(VPM.vimrc_path, "r") do |file|
      file.lines.any? {|line| line =~ /source #{VPM.vpmrc_path}/}
    end
  end
end

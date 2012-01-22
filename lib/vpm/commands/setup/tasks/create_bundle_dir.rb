module VPM::Commands::Setup::Tasks
  class CreateBundleDir < CreateDirectory
    def initialize
      super VPM.bundle_dir_path
    end
  end
end

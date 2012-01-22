require 'spec_helper'

module VPM::Commands::Setup::Tasks
  describe CreateBundleDir do
    before do
      @task = CreateBundleDir.new
    end

    context "#perform" do
      it "works even if the directory already exists" do
        Dir.exists?(VPM.bundle_dir_path).should be_true
        @task.perform
        Dir.exists?(VPM.bundle_dir_path).should be_true
      end
    end

    context "#undo" do
      it "removes #{VPM.bundle_dir_path} if this task created it" do
        FileUtils.rmdir VPM.bundle_dir_path
        Dir.exists?(VPM.bundle_dir_path).should be_false
        @task.perform
        Dir.exists?(VPM.bundle_dir_path).should be_true
        @task.undo
        Dir.exists?(VPM.bundle_dir_path).should be_false
      end
    end
  end
end

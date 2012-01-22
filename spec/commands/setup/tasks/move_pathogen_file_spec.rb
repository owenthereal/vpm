require 'spec_helper'

module VPM::Commands::Setup::Tasks
  describe MovePathogenFile do
    before do
      @temp_dir         = File.expand_path "temp"
      @source_path      = File.join(@temp_dir, "pathogen", "autoload", "pathogen.vim")
      FileUtils.mkdir_p File.join(@temp_dir, "pathogen", "autoload")
      FileUtils.touch   @source_path
      @autoload_path    = File.join(VPM.vim_dir_path, "autoload")
      @destination_path = File.join(@autoload_path, "pathogen.vim")
      FileUtils.mkdir_p @autoload_path
      @task             = MovePathogenFile.new @temp_dir
    end

    context "#perform" do
      it "moves the pathogen.vim file from its current location to vim's autoload directory" do
        File.exists?(@destination_path).should be_false
        @task.perform
        File.exists?(@destination_path).should be_true
      end
    end

    context "#undo" do
      it "removes pathogen.vim if the task installed it" do
        FileUtils.rm @destination_path
        File.exists?(@destination_path).should be_false
        @task.perform
        File.exists?(@destination_path).should be_true
        @task.undo
        File.exists?(@destination_path).should be_false
      end

      it "does not remove the file if it already existed" do
        FileUtils.touch @destination_path
        File.exists?(@destination_path).should be_true
        @task.perform
        File.exists?(@destination_path).should be_true
        @task.undo
        File.exists?(@destination_path).should be_true
      end
    end
  end
end

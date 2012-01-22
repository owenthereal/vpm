require 'spec_helper'

module VPM::Commands::Setup::Tasks
  describe CreateDirectory do
    before do
      @dir  = File.expand_path "temp"
      @task = CreateDirectory.new @dir
    end

    context "#perform" do
      it "creates the directory if it doesn't already exist" do
        Dir.exists?(@dir).should be_false
        @task.perform
        Dir.exists?(@dir).should be_true
      end

      it "works even if the directory already exists" do
        Dir.exists?(@dir).should be_true
        @task.perform
        Dir.exists?(@dir).should be_true
      end
    end

    context "#undo" do
      it "removes #{@dir} if this task created it" do
        FileUtils.rmdir @dir
        Dir.exists?(@dir).should be_false
        @task.perform
        Dir.exists?(@dir).should be_true
        @task.undo
        Dir.exists?(@dir).should be_false
      end
    end
  end
end

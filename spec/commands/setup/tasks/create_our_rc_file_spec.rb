require 'spec_helper'

module VPM::Commands::Setup::Tasks
  describe CreateOurRCFile do
    before do
      @task = CreateOurRCFile.new
    end

    context "#perform" do
      it "creates the file if it doesn't exist" do
        File.exists?(VPM.vpmrc_path).should be_false
        @task.perform
        File.exists?(VPM.vpmrc_path).should be_true
      end

      it "inserts the call to pathogen#infect into the file" do
        @task.perform
        File.open(VPM.vpmrc_path, "r") do |file|
          file.read.should include "call pathogen#infect()"
        end
      end
    end

    context "#undo" do
      it "removes the rc file" do
        @task.perform
        File.exists?(VPM.vpmrc_path).should be_true
        @task.undo
        File.exists?(VPM.vpmrc_path).should be_false
      end
    end
  end
end

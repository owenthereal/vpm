require 'spec_helper'

module VPM::Commands::Setup::Tasks
  describe InjectOurLoadScript do
    context "#perform" do
      it "sources our file at the top of the user's vimrc" do
        Dir.mktmpdir do |temp_dir|
          @task = InjectOurLoadScript.new(temp_dir)
          FileUtils.touch File.expand_path(VPM.vimrc_path)
          File.read(VPM.vimrc_path).should_not include "source #{VPM.vpmrc_path}"
          @task.perform
          File.read(VPM.vimrc_path).start_with?("source #{VPM.vpmrc_path}").should be_true
        end
      end

      it "retains exactly the same text as the old file" do
        Dir.mktmpdir do |temp_dir|
          @task = InjectOurLoadScript.new(temp_dir)
          File.open(VPM.vimrc_path, "w") {|file| file.puts "test\nother"}
          File.read(VPM.vimrc_path).should_not include "source #{VPM.vpmrc_path}"
          @task.perform
          File.read(VPM.vimrc_path).should == "source #{VPM.vpmrc_path}\ntest\nother\n"
        end
      end
    end

    context "#undo" do
      it "replaces the old file" do
        Dir.mktmpdir do |temp_dir|
          @task = InjectOurLoadScript.new(temp_dir)
          File.open(VPM.vimrc_path, "w") {|file| file.print "test\nother"}
          File.read(VPM.vimrc_path).should_not include "source #{VPM.vpmrc_path}"
          @task.perform
          File.read(VPM.vimrc_path).should == "source #{VPM.vpmrc_path}\ntest\nother\n"
          @task.undo
          File.read(VPM.vimrc_path).should == "test\nother"
        end
      end
    end
  end
end

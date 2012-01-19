require 'spec_helper'

module VPM::Commands
  describe Install do
    it "intalls a plugin" do
      VPM::Git.should_receive(:clone).with("https://xxx.git", "command-t")
      VPM::Git.should_receive(:current_revision)
      Install.run(VPM::Plugin.new("command-t", :git, :remote => "https://xxx.git"))
    end
  end
end

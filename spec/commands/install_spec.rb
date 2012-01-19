require 'spec_helper'

module VPM::Commands
  describe Install do
    it "intalls a plugin" do
      Install::GitInstall.should_receive(:run)
      Install.run(VPM::Plugin.new("command-t", :git, :remote => "https://xxx.git"))
    end
  end
end

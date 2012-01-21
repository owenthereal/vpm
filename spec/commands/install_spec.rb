require 'spec_helper'

module VPM::Commands
  describe Install do
    it "intalls a plugin" do
      Install::GitInstall.should_receive(:run)
      options = { :name => "command-t", :type => :git, :remote => "https://xxx.git" }
      Install.call(options)
    end
  end
end

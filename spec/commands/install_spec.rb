require 'spec_helper'

module VPM::Commands
  describe Install do
    it "intalls a plugin" do
      install_command = Install.new

      Install::GitInstall.should_receive(:run)
      options = { :plugin_name => "command-t", :type => :git, :remote => "https://xxx.git" }
      install_command.call(options)
    end
  end
end

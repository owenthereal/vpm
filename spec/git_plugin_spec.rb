require 'spec_helper'

describe VPM::GitPlugin do
  it "intalls the plugin if it hasn't" do
    mock_git_commander = double(:mock_git_commander)
    mock_git_commander.should_receive(:clone).with("https://xxx.git", "#{ENV['HOME']}/.vim/bundle")

    plugin = VPM::GitPlugin.new("command-t", :git => "https://xxx.git")
    plugin.git_commander = mock_git_commander
    plugin.install
  end
end

require 'spec_helper'

describe VPM::GitPlugin do
  it "intalls the plugin if it hasn't" do
    mock_git_command = MiniTest::Mock.new
    mock_git_command.expect(:clone, true, ["https://xxx.git", "#{ENV['HOME']}/.vim/bundle"])
    plugin = VPM::GitPlugin.new("command-t", :git => "https://xxx.git")
    plugin.git_commander = mock_git_command
    plugin.install
    mock_git_command.verify
  end
end

require 'spec_helper'

describe VPM::CommandOptions::Install do
  it "parses plugin_name, remote and tag" do
    command_options = VPM::CommandOptions::Install.new
    options = command_options.parse!(["command-t", "--git", "http://xxx.git", "--tag", "1.2.0"])

    options[:plugin_name].should == "command-t"
    options[:type].should == :git
    options[:remote].should == "http://xxx.git"
    options[:tag].should == "1.2.0"
  end

  it "leaves out plugin name if it's not provided" do
    command_options = VPM::CommandOptions::Install.new
    options = command_options.parse!([])

    options[:plugin_name].should be_nil
  end
end

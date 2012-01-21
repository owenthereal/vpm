require 'spec_helper'

describe VPM::CommandOptions::Empty do
  it "parses no options" do
    command_options = VPM::CommandOptions::Empty.new
    options = command_options.parse!(["foo", "bar"])

    options.size.should == 1
    options[:plugin_name].should == "foo"
  end
end

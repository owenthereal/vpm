require 'spec_helper'

describe VPM::CommandOptions do
  describe ".[]" do
    it "returns EmptyCommandOptions if no class found" do
      command_options = VPM::CommandOptions["foo"]
      command_options.class.should == VPM::CommandOptions::Empty
    end
  end
end

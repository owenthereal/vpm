require 'spec_helper'
require 'ostruct'

describe VPM::Commands::Update do
  subject                 { VPM::Commands::Update.new }
  let(:installed_plugins) { [OpenStruct.new(:name => "one")] }

  before { VPM.stub(:plugins).and_return installed_plugins }

  context "#call" do
    context "given a list of plugin names" do
      it "updates those plugins" do
        subject.should_receive(:update_plugin).with "plugin"
        subject.call :plugin_names => ["plugin"]
      end

      it "doesn't update other plugins" do
        subject.should_receive(:update_plugin).with "plugin"
        subject.call :plugin_names => ["plugin"]
      end
    end

    context "without a list of plugin names" do
      it "updates all installed plugins" do
        subject.should_receive(:update_plugin).with "one"
        subject.call
      end
    end
  end
end

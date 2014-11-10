require 'spec_helper'

module VPM::Core
  describe Plugins do
    let(:plugins) { Plugins.new }

    it "dumps plugins as YAML" do
      plugins.plugin_installed(Plugin.new("command-t", :git, :remote => "http://xxx.git", :tag => "1.2.0"))
      plugins.dump.should == YAML.dump([{:name => "command-t", :type => :git, :options => {:remote => "http://xxx.git", :tag => "1.2.0"}}])
    end

    it "loads plugins from YAML" do
      plugins_yaml = <<-EOS
---
- :name: command-t
  :type: :git
  :options:
    :remote: http://xxx.git
    :tag: 1.2.0
      EOS
      plugins.load(plugins_yaml)
      plugins.all.size.should == 1

      plugin = plugins.all.first
      plugin.name.should == 'command-t'
      plugin.type.should == :git
      plugin.options.size.should == 2
      plugin.options[:remote].should == 'http://xxx.git'
      plugin.options[:tag].should == '1.2.0'
    end

    it "returns empty when content to deserialize is empty" do
      plugins.load("")
      plugins.all.should be_empty
    end

    it "returns empty when loading from an empty file" do
      FileUtils.touch('foo')
      plugins = Plugins.load_from_file('foo')
      plugins.all.should be_empty
    end

    context "#do_to" do
      it "executes the block on the given plugin" do
        mock_plugin = double("plugin")
        mock_plugin.stub(:name).and_return "command-t"
        mock_plugin.should_receive :count_it!
        plugins.plugin_installed mock_plugin
        plugins.do_to "command-t" do |plugin|
          plugin.count_it!
        end
      end

      it "does nothing if the plugin doesn't exist" do
        mock_plugin = double("plugin")
        mock_plugin.stub(:name).and_return "command-t"
        plugins.plugin_installed mock_plugin
        plugins.do_to "thingy" do |plugin|
          plugin.count_it!
        end
      end
    end
  end
end

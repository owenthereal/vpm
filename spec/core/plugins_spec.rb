require 'spec_helper'

module VPM::Core
  describe Plugins do
    it "dumps plugins as YAML" do
      plugins = Plugins.new
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
      plugins = Plugins.new
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
      plugins = Plugins.new
      plugins.load("")
      plugins.all.should be_empty
    end

    it "returns empty when loading from an empty file" do
      FileUtils.touch('foo')
      plugins = Plugins.load_from_file('foo')
      plugins.all.should be_empty
    end
  end
end

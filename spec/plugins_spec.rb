require 'spec_helper'
require 'tempfile'

describe VPM::Plugins do
  it "dumps plugins as YAML" do
    plugins = VPM::Plugins.new
    plugins.plugin_installed(VPM::Plugin.new("command-t", :git, :remote => "http://xxx.git", :tag => "1.2.0"))
    plugins.dump.should == <<-EOS
---
- :name: command-t
  :type: :git
  :options:
    :remote: http://xxx.git
    :tag: 1.2.0
    EOS
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
    plugins = VPM::Plugins.new
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
    plugins = VPM::Plugins.new
    plugins.load("")
    plugins.all.should be_empty
  end

  it "returns empty when loading from an empty file" do
    FileUtils.touch('foo')
    file = File.new('foo')
    plugins = VPM::Plugins.load_from_file(file)
    plugins.all.should be_empty
  end
end

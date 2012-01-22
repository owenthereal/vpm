require 'spec_helper'

module VPM::Core
  describe ManifestParser do
    it "parses one plugin" do
      parser = ManifestParser.new
      parser.parse "plugin 'command-t', :git => 'https://github.com/agitrepo.git', :tag => '1.0.2'"

      parser.plugins.size.should == 1
    end

    it "parses multiple plugins" do
      parser = ManifestParser.new
      parser.parse <<-END
        plugin 'command-t', :git => 'https://github.com/agitrepo.git', :tag => '1.0.2'
        plugin 'turn', :git => 'https://github.com/adifferent_repo.git'
        plugin 'surround', :git => 'http://anothersite.com/repo.git'
      END

      parser.plugins.size.should == 3
    end

    it "ignores duplicate entries" do
      parser = ManifestParser.new
      parser.parse <<-END
        plugin 'command-t', :git => 'https://github.com/agitrepo.git', :tag => '1.0.2'
        plugin 'command-t', :git => 'https://github.com/agitrepo.git', :tag => '1.0.2'
      END

      parser.plugins.size.should == 1
    end
  end
end

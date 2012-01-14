require 'spec_helper'

describe VPM::ManifestParser do
  it "parses one plugin" do
    parser = VPM::ManifestParser.new
    parser.parse "plugin 'command-t', :git => 'https://github.com/agitrepo.git', :tag => '1.0.2'"

    parser.plugins.size.must_equal 1
  end

  it "parses multiple plugins" do
    parser = VPM::ManifestParser.new
    parser.parse <<-END
      plugin 'command-t', :git => 'https://github.com/agitrepo.git', :tag => '1.0.2'
      plugin 'turn', :git => 'https://github.com/adifferent_repo.git'
      plugin 'surround', :git => 'http://anothersite.com/repo.git'
    END

    parser.plugins.size.must_equal 3
  end

  it "ignores duplicate entries" do
    parser = VPM::ManifestParser.new
    parser.parse <<-END
      plugin 'command-t', :git => 'https://github.com/agitrepo.git', :tag => '1.0.2'
      plugin 'command-t', :git => 'https://github.com/agitrepo.git', :tag => '1.0.2'
    END

    parser.plugins.size.must_equal 1
  end

  it "parses to the right class of Plugin" do
    parser = VPM::ManifestParser.new
    parser.parse <<-END
      plugin 'command-t', :git => 'https://github.com/agitrepo.git', :tag => '1.0.2'
      plugin 'command-t', :git => 'https://github.com/agitrepo.git', :tag => '1.0.2'
    END

    parser.plugins.first.must_be_kind_of VPM::GitPlugin
  end
end

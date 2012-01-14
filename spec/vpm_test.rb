require 'test_helper'

describe VPM do
  it "parses install command with args" do
    parser = MiniTest::Mock.new

    VPM.run(['intstall', 'xxx.git'])
    # ['<command'>, args]
    # InstallCommand.run(args)
    # RemoveCommadn.run(args)
    VPM.parse
  end
end

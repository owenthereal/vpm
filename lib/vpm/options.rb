module VPM
  module Options
    def self.parser(command)
      if command == "install"
        Install.new
      end
    end

    def self.parse!(command, args)
      parser(command).parse!(args)
    end
  end
end

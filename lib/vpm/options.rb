module VPM
  module Options
    def self.parse!(command, args)
      if command == "install"
        Install.parse!(args)
      end
    end
  end
end

module VPM
  module Utils
    module Git
      def self.clone(repo, dir)
        `git clone #{repo} #{dir}`
        $?.to_i == 0
      end

      def self.checkout_tag(tag)
        `git checkout -b #{tag} #{tag}`
        $?.to_i == 0
      end

      def self.current_revision
        `git rev-parse --verify HEAD`.strip
      end
    end
  end
end

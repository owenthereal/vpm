module VPM
  module Git
    def self.clone(repo, dir)
      `git clone #{repo} #{dir}`
    end

    def self.checkout_tag(tag)
      `git checkout -b #{tag} #{tag}`
    end
  end
end

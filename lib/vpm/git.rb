module VPM
  module Git
    def self.clone(repo, dir)
      `git clone #{repo} #{dir}`
      $?.to_i == 0 ? true : false
    end

    def self.checkout_tag(tag)
      `git checkout -b #{tag} #{tag}`
      $?.to_i == 0 ? true : false
    end
  end
end

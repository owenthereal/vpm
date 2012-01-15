# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vpm/version"

Gem::Specification.new do |s|
  s.name        = "vpm"
  s.version     = VPM::VERSION
  s.authors     = ["Jingwen Owen Ou", "Michael Baker"]
  s.email       = ["jingweno@gmail.com"]
  s.homepage    = "https://github.com/jingweno/vpm"
  s.summary     = %q{An awesome utility for managing Vim plugins}

  s.rubyforge_project = "vpm"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rake"
  s.add_development_dependency "turn"
  # s.add_runtime_dependency "rest-client"
end

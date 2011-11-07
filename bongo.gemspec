# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bongo/version"

Gem::Specification.new do |s|
  s.name        = "bongo"
  s.version     = Bongo::VERSION
  s.authors     = ["Paweł Pacana"]
  s.email       = ["pawel.pacana@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Simple mongo persistence for models under eventmachine.}
  s.description = %q{This gem provides persistence for your models if you run your code under eventmachine.}

  s.rubyforge_project = "bongo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "em-mongo", "~> 0.4.1"
  s.add_runtime_dependency "activemodel", "~> 3.1"
  s.add_runtime_dependency "eventmachine", "~> 1.0.0.beta.4"
  s.add_development_dependency "em-spec", "~> 0.2.5"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'boxes/version'

Gem::Specification.new do |spec|
  spec.name          = 'boxes'
  spec.version       = Boxes::VERSION
  spec.authors       = ['Nick Charlton']
  spec.email         = ['nick@nickcharlton.net']

  spec.summary       = 'A command line tool to take the complexity out of '\
                       'building Vagrant boxes.'
  spec.description   = <<-EOF
    boxes takes the complexity out of building custom Vagrant boxes.

    It's a command line tool which provides a set of templates and scripts to
    combine as you need. There are also a set of pre-build boxes which are
    regenerated regularly.'
  EOF
  spec.homepage      = 'https://github.com/nickcharlton/boxes'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_dependency "claide"
  spec.add_dependency "colored"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "climate_control"
  spec.add_development_dependency "fakefs"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

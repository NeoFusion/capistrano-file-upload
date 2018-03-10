# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-file-upload'
  spec.version       = '0.1.0'
  spec.authors       = ['Evgeniy NeoFusion']
  spec.email         = ['evgeniy@neofusion.ru']
  spec.summary       = %q{Upload plugin for Capistrano 3.x}
  spec.description   = %q{Upload local files to remote server (plugin for Capistrano 3.x)}
  spec.homepage      = 'https://github.com/NeoFusion/capistrano-file-upload'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '~> 3.5'
  spec.add_dependency 'sshkit', '~> 1.9'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
end

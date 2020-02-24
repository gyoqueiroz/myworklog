# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'myworklog'
  s.version   = '1.1.1'
  s.platform  = Gem::Platform::RUBY
  s.summary   = 'My Work Log'
  s.description = 'Log your work from cmd and keep track of what you have done... just in case your boss ask'
  s.authors   = ['Gyowanny Queiroz']
  s.email     = ['gyowanny@gmail.com']
  s.homepage  = 'http://rubygems.org/gems/myworklog'
  s.license   = 'MIT'
  s.files     = Dir.glob('{lib,bin}/**/*')
  s.require_path = 'lib'
  s.executables = ['myworklog']
  s.metadata    = { 'source_code_uri' => 'https://github.com/gyoqueiroz/myworklog' }
end

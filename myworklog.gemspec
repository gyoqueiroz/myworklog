Gem::Specification.new do |s|
    s.name      = 'myworklog'
    s.version   = '1.0.0'
    s.platform  = Gem::Platform::RUBY
    s.summary   = 'My Work Log'
    s.description = 'Log your work from cmd and keep track of what you have done. Just in case your boss asks'
    s.authors   = ['Gyowanny Queiroz']
    s.email     = ['gyowanny@gmail.com']
    s.homepage  = 'http://rubygems.org/gems/myworklog'
    s.license   = 'MIT'
    s.files     = Dir.glob("{lib,bin}/**/*") # This includes all files under the lib directory recursively, so we don't have to add each one individually.
    s.require_path = 'lib'
    s.executables = ['myworklog']
    s.metadata    = { "source_code_uri" => "https://github.com/gyoqueiroz/myworklog" }
end
if defined?(Gem.post_reset_hooks)
  Gem.post_reset_hooks.reject!{ |hook| hook.source_location.first =~ %r{/bundler/} }
  Gem::Specification.reset
#load 'rubygems/custom_require.rb'
  alias gem require
end

require 'colored'
require 'bond'
require 'pry-coolline'

Pry.config.prompt = ->(obj, nest_level, _){ "#{obj} ".bold << "⭔ ".red }

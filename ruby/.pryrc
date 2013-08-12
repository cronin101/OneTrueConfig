require 'colored'
require 'bond'
require 'pry-coolline'

Pry.config.prompt = ->(obj, nest_level, _){ "#{obj} ".bold << "⭔ ".red }

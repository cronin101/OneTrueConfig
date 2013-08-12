require 'pathname'
require 'fileutils'

require './lib/sync_sugar.rb'

class OneTrueConfig

  CONFIGS = %w{Vim Xmonad Tmux Zsh Haskell Ruby}
  CONFIGS.each { |config| require "./#{config.downcase}/sync.rb" }

  def self.sync_all
  puts 'Updating submodules'.green
  `git submodule update --init`
  `git submodule foreach git pull origin master`

    CONFIGS.each do |config|
      klass = const_get(config + 'Sync')
      klass.send :include, SyncSugar # Sprinkle on some sugar!
      klass.new(this_dir + config.downcase).sync
    end
  end

  private

  def self.this_dir
    Pathname Dir.pwd
  end

end


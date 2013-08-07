require 'pathname'
require 'fileutils'

require './lib/sync_sugar.rb'

class OneTrueConfig

  CONFIGS = %w{Vim Xmonad Tmux Zsh}
  CONFIGS.each { |config| require "./#{config.downcase}/sync.rb" }
  SYNCHERS = CONFIGS.map { |name| const_get(name + 'Sync') }

  def self.sync_all
  puts 'Updating submodules'.green
  `git submodule update --init`
  `git submodule foreach git pull origin master`

    SYNCHERS.each do |klass|
      klass.send :include, SyncSugar # Sprinkle on some sugar!
      klass.new(this_dir).sync
    end
  end

  private

  def self.this_dir
    Pathname Dir.pwd
  end

end


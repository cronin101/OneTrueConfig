#!/usr/bin/env ruby

require 'pathname'
require 'fileutils'

require './vim/sync.rb'
require './xmonad/sync.rb'

require './sync_sugar.rb'

class OneTrueConfig

  SYNCHERS = [VimSync, XmonadSync]

  def self.sync_all
  puts 'Updating submodules'.green
  `git submodule foreach git pull origin master`

    SYNCHERS.each do |klass|
      klass.send(:include, SyncSugar)
      klass.new(this_dir).sync
    end
  end

  private

  def self.this_dir
    Pathname(Dir.pwd)
  end

end

OneTrueConfig::sync_all

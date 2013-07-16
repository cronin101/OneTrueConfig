#!/usr/bin/env ruby

require 'pathname'
require 'fileutils'

require './vim/sync.rb'

require './sync_sugar.rb'

class OneTrueConfig

  def self.synchers
    [VimSync]
  end

  def self.sync_all
    synchers.each do |klass|
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

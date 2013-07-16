#!/usr/bin/env ruby

require 'pathname'
require 'fileutils'
require './vim/sync.rb'

class OneTrueConfig

  def self.synchers
    [VimSync]
  end

  def self.sync_all
    synchers.each do |klass|
      klass.new(this_dir).sync
    end
  end

  private

  def self.this_dir
    Pathname(Dir.pwd)
  end

end

OneTrueConfig::sync_all

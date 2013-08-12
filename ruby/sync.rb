class RubySync < Struct.new(:dir)

  def sync
    replace_with_symlink '~/.pryrc', (dir + '.pryrc')
  end

end


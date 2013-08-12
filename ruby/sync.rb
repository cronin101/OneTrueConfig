class RubySync < Struct.new(:dir)

  def sync
    replace_with_symlink '~/.pryrc', (dir + '.pryrc')
    replace_with_symlink '~/.ruby-version', (dir + '~/.ruby-version')
  end

end


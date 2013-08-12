class VimSync < Struct.new(:dir)

  def sync
    replace_with_symlink '~/.vimrc', (dir + '.vimrc')

    ensure_directory('~/.vim')

    replace_with_symlink '~/.vim/autoload', (dir + 'autoload')
    replace_with_symlink '~/.vim/bundle', (dir + 'bundle')
    replace_with_symlink '~/.vim/snippets', (dir + 'snippets')
  end

end


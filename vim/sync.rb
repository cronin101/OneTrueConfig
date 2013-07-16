class VimSync < Struct.new(:otc_dir)

  def dir
    otc_dir + 'vim'
  end

  def sync
    replace_with_symlink "~/.vimrc", (dir + '.vimrc')

    ensure_directory(File.expand_path("~/.vim"))

    auto_load = File.expand_path("~/.vim/autoload")
    replace_with_symlink auto_load, (dir + 'autoload')

    bundle = File.expand_path("~/.vim/bundle")
    replace_with_symlink bundle, (dir + 'bundle')
  end

end


class ZshSync < Struct.new(:otc_dir)

  def dir
    otc_dir + 'zsh'
  end

  def sync
    replace_with_symlink '~/.zshrc', (dir + '.zshrc')
    ensure_directory '~/.oh-my-zsh'
    replace_with_symlink '~/.oh-my-zsh/custom', (dir + '.oh-my-zsh' + 'custom')
  end

end


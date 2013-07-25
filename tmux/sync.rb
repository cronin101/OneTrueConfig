class TmuxSync < Struct.new(:otc_dir)

  def dir
    otc_dir + 'tmux'
  end

  def sync
    replace_with_symlink '~/.tmux.conf', (dir + '.tmux.conf')
  end

end


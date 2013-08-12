class TmuxSync < Struct.new(:dir)

  def sync
    replace_with_symlink '~/.tmux.conf', (dir + '.tmux.conf')
  end

end


class XmonadSync < Struct.new(:dir)

  def sync
    ensure_directory('~/.xmonad')

    replace_with_symlink '~/.xmonad/xmonad.hs', (dir + 'xmonad.hs')
    replace_with_symlink '~/.xmobarrc', (dir + '.xmobarrc')
  end

end


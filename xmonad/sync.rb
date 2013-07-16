class XmonadSync < Struct.new(:otc_dir)

  def dir
    otc_dir + 'xmonad'
  end

  def sync
    ensure_directory('~/.xmonad')

    replace_with_symlink '~/.xmonad/xmonad.hs', (dir + 'xmonad.hs')
    replace_with_symlink '~/.xmobarrc', (dir + '.xmobarrc')
  end

end


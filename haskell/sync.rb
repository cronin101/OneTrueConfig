class HaskellSync < Struct.new(:dir)

  def sync
    replace_with_symlink '~/.ghci', (dir + '.ghci')
  end

end


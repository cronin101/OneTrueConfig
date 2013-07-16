class VimSync < Struct.new(:this_dir)

  def sync
    vimrc = File.expand_path("~/.vimrc")
    puts 'Removing old .vimrc'
    FileUtils.rm_f vimrc

    puts 'Symlinking tracked .vimrc'
    File.symlink (this_dir + 'vim' + '.vimrc').to_s, vimrc.to_s

    bundle = Pathname(File.expand_path("~/.vim/bundle"))
    puts 'Removing old vim bundles'
    FileUtils.rm_rf bundle.to_s

    puts 'Symlinking tracked vim bundles'
    File.symlink (this_dir + 'vim' + 'bundle').to_s, bundle
  end

end


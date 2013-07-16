require 'colored'

module SyncSugar

  def ensure_directory(dependency)
    unless File.exists?(dependency.to_s)
      Dir.mkdir(dependency.to_s)
    end
  end

  def replace_with_symlink(original_file, target)
    original_file_path = File.expand_path original_file
    target_path = File.expand_path target

    puts "#{self.class}: Removing #{original_file_path}".yellow
    FileUtils.rm_rf original_file_path

    puts "#{self.class}: Symlinking #{original_file_path} -> #{target_path}".green
    File.symlink target_path, original_file_path
  end

end

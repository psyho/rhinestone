require 'fileutils'
require 'digest/sha2'

module Rhinestone
  class FilesystemCacheBackend
    takes :base_directory

    def get(key)
      File.read(file_name(key)) rescue nil
    end

    def set(key, value)
      file = file_name(key)
      FileUtils.mkdir_p(File.dirname(file))
      File.open(file, "w") do |f|
        f.write value
      end
    end

    private

    def file_name(key)
      sha = Digest::SHA2.hexdigest(key)
      parts = sha.gsub(/.{16}/){|s| s+'|'}.split('|')
      return File.expand_path(File.join(*parts), base_directory)
    end

  end
end

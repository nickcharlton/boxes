require "pathname"
require "securerandom"
require "tmpdir"
require "fileutils"

def tmpdir
  @tmp_dir ||= begin
    system_tmp = Dir.tmpdir
    random_hash = SecureRandom.hex(10)

    Pathname.new(system_tmp).join("boxes-#{random_hash}")
  end
end

def mktmpdir
  FileUtils.mkdir_p(tmpdir)
end

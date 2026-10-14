# frozen_string_literal: true

require "download_strategy"

# Keep credentials inside gh: neither the tap nor curl arguments contain a token.
class HellcodePrivateReleaseDownloadStrategy < AbstractFileDownloadStrategy
  def fetch(timeout: nil)
    match = %r{\Ahttps://github\.com/random1st/hellcode/releases/download/(v[0-9]+\.[0-9]+\.[0-9]+)/([A-Za-z0-9._-]+)\z}.match(url)
    raise "Invalid Hellcode release URL" unless match

    gh = HOMEBREW_PREFIX/"bin/gh"
    unless gh.executable?
      raise "Private Hellcode releases require GitHub CLI: brew install gh; gh auth login"
    end

    lock = DownloadLock.new(temporary_path)
    begin
      lock.lock_or_wait(quiet: quiet?, timeout: timeout)
      unless cached_location.exist?
        ohai "Downloading private Hellcode release #{match[1]}"
        temporary_path.dirname.mkpath
        command! gh.to_s, args: ["release", "download", match[1], "--repo", "random1st/hellcode",
                                "--pattern", match[2], "--output", temporary_path.to_s, "--clobber"],
                         timeout: timeout, env: { "GH_DEBUG" => nil }
        temporary_path.rename(cached_location)
      end
      create_symlink_to_cached_download(cached_location)
    ensure
      lock.unlock(unlink: true)
    end
  end

  def clear_cache
    super
    FileUtils.rm_f(temporary_path)
  end
end

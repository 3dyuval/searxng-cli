class SearxngCli < Formula
  desc "Shell wrapper for SearXNG with carapace completions"
  homepage "https://github.com/3dyuval/searxng-cli"
  url "https://github.com/3dyuval/searxng-cli/archive/refs/heads/main.tar.gz"
  version "0.1.0"
  license "MIT"

  depends_on "jq"

  def install
    system "make", "install", "PREFIX=#{prefix}", "VERSION=#{version}"
  end

  test do
    assert_match "searxng-cli", shell_output("#{bin}/searxng --version")
  end
end

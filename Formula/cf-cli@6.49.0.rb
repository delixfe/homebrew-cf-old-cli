require 'formula'

class CfCliAT6490 < Formula
  homepage 'https://code.cloudfoundry.org/cli'
  version '6.49.0'

  if OS.mac?
    url 'https://github.com/cloudfoundry/cli/releases/download/v6.49.0/cf-cli_6.49.0_osx.tgz'
    sha256 '7dc6f0e32358b86016a97c3e5c987024169cac5512df1a548aceab9ebad316c7'
  elsif OS.linux?
    url 'https://github.com/cloudfoundry/cli/releases/download/v6.49.0/cf-cli_6.49.0_linux_x86-64.tgz'
    sha256 'fafcd4a701897c5eb44168ca7bd0c4502e442ea65324ffaca71b0a4b344c9a99'
  end

  depends_on :arch => :x86_64

  def install
    bin.install 'cf'
    (bash_completion/"cf-cli").write <<-completion
# bash completion for Cloud Foundry CLI

_cf-cli() {
    # All arguments except the first one
    args=("${COMP_WORDS[@]:1:$COMP_CWORD}")
    # Only split on newlines
    local IFS=$'\n'
    # Call completion (note that the first element of COMP_WORDS is
    # the executable itself)
    COMPREPLY=($(GO_FLAGS_COMPLETION=1 ${COMP_WORDS[0]} "${args[@]}"))
    return 0
}
complete -F _cf-cli cf
    completion
    doc.install 'LICENSE'
    doc.install 'NOTICE'
  end

  test do
    system "#{bin}/cf"
  end
end

require 'formula'

class CfCliAT6520 < Formula
  homepage 'https://code.cloudfoundry.org/cli'
  version '6.52.0'

  if OS.mac?
    head 'https://packages.cloudfoundry.org/edge?arch=macosx64&source=homebrew'
    url 'https://packages.cloudfoundry.org/homebrew/cf-6.52.0.tgz'
    sha256 'c2b1883e980e823fdafe2531b8ee9742b05645b3c7dda4288b7a6ba3ed3e405d'
  elsif OS.linux?
    head 'https://packages.cloudfoundry.org/edge?arch=linux64&source=homebrew'
    url 'https://packages.cloudfoundry.org/stable?release=linux64-binary&version=6.52.0&source=homebrew'
    sha256 '8438c082bee652aa5e21cdc3e92348aac4751af2ea8afff37f402f2780efef60'
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

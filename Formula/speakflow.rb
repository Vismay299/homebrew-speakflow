class Speakflow < Formula
  desc "Fully local push-to-talk dictation app for Apple Silicon Macs"
  homepage "https://github.com/Vismay299/speakflow"
  url "https://github.com/Vismay299/speakflow/releases/download/v0.1.2/SpeakFlow-0.1.2.tar.gz"
  sha256 "f71c2dfd555912e4dc138a7ee6721b1ffe82b612b7db0b98c6fd2509811335aa"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :ventura
  depends_on "python@3.12"

  def install
    app_source = buildpath.glob("**/SpeakFlow.app").first
    raise "SpeakFlow.app not found in release artifact" unless app_source

    app_target = prefix/"SpeakFlow.app"
    cp_r app_source, app_target

    python = Formula["python@3.12"].opt_bin/"python3"

    (bin/"speakflow").write <<~EOS
      #!/bin/bash
      set -euo pipefail
      if [ ! -x "#{libexec}/bin/python3" ]; then
        "#{python}" -m venv "#{libexec}"
        "#{libexec}/bin/pip" install --upgrade pip
        "#{libexec}/bin/pip" install mlx-whisper
      fi
      export SPEAKFLOW_PYTHON="#{libexec}/bin/python3"
      open "#{app_target}"
    EOS
  end

  def caveats
    <<~EOS
      SpeakFlow uses a Brew-managed Python runtime at:
        #{libexec}/bin/python3

      On first launch, the `speakflow` command creates a private virtualenv and
      installs `mlx-whisper` automatically.

      Launch SpeakFlow with:
        speakflow

      Because the app is unsigned, macOS may still show a first-open warning
      depending on your Gatekeeper settings.
    EOS
  end

  test do
    assert_predicate prefix/"SpeakFlow.app", :exist?
    assert_match "SPEAKFLOW_PYTHON", (bin/"speakflow").read
    assert_match "mlx-whisper", (bin/"speakflow").read
  end
end

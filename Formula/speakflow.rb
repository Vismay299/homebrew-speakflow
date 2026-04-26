class Speakflow < Formula
  include Language::Python::Virtualenv

  desc "Fully local push-to-talk dictation app for Apple Silicon Macs"
  homepage "https://github.com/Vismay299/speakflow"
  url "https://github.com/Vismay299/speakflow/releases/download/v0.1.2/SpeakFlow-0.1.2.tar.gz"
  sha256 "f71c2dfd555912e4dc138a7ee6721b1ffe82b612b7db0b98c6fd2509811335aa"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :ventura
  depends_on "python@3.12"

  resource "mlx-whisper" do
    url "https://files.pythonhosted.org/packages/22/b7/a35232812a2ccfffcb7614ba96a91338551a660a0e9815cee668bf5743f0/mlx_whisper-0.4.3-py3-none-any.whl"
    sha256 "6b82b6597a994643a3e5496c7bc229a672e5ca308458455bfe276e76ae024489"
  end

  def install
    venv = virtualenv_create(libexec, Formula["python@3.12"].opt_bin/"python3")
    venv.pip_install resources

    app_source = Dir["SpeakFlow.app"].first
    raise "SpeakFlow.app not found in release artifact" unless app_source

    app_target = prefix/"SpeakFlow.app"
    cp_r app_source, app_target

    (bin/"speakflow").write <<~EOS
      #!/bin/bash
      export SPEAKFLOW_PYTHON="#{libexec}/bin/python3"
      open "#{app_target}"
    EOS
  end

  def caveats
    <<~EOS
      SpeakFlow uses a Brew-managed Python runtime at:
        #{libexec}/bin/python3

      Launch SpeakFlow with:
        speakflow

      Because the app is unsigned, macOS may still show a first-open warning
      depending on your Gatekeeper settings.
    EOS
  end

  test do
    assert_predicate prefix/"SpeakFlow.app", :exist?
    assert_predicate libexec/"bin/python3", :exist?
    assert_match "SPEAKFLOW_PYTHON", (bin/"speakflow").read
  end
end

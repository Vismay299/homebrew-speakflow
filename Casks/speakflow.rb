cask "speakflow" do
  version "0.1.5"
  sha256 "d26653eeee83d52c2625e822ce2d59e1722ed573ea6e6938c2401779a1165d39"

  url "https://github.com/Vismay299/speakflow/releases/download/v#{version}/SpeakFlow-#{version}.dmg"
  name "SpeakFlow"
  desc "Push-to-talk dictation for your Mac. Fully local, no cloud."
  homepage "https://github.com/Vismay299/speakflow"

  depends_on macos: ">= :ventura"
  depends_on arch: :arm64

  app "SpeakFlow.app"

  caveats <<~EOS
    SpeakFlow requires the mlx-whisper Python package for transcription.
    Install it with:
      pip3 install mlx-whisper

    On first launch, the app will download the whisper-large-v3-turbo
    model (~800MB) and cache it locally. Subsequent launches are instant.

    SpeakFlow also requires Microphone and Accessibility permissions —
    you will be prompted on first launch.
  EOS
end

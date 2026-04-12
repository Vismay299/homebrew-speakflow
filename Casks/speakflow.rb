cask "speakflow" do
  version "0.1.0"
  sha256 "27db3010c407c4e23cd7b9083a7c089c998b2d6b3b71843c04c0f04e23eacc4f"

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
      pip install mlx-whisper

    On first launch, the app will download the whisper-large-v3-turbo
    model (~800MB) and cache it locally. Subsequent launches are instant.

    SpeakFlow also requires Microphone and Accessibility permissions —
    you will be prompted on first launch.
  EOS
end

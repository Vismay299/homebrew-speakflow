cask "speakflow" do
  version "0.1.1"
  sha256 "85dc55e5dcde31a9a81ab49666ea9bd7bc5d1e0da365c6ad45453b4101f4863d"

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

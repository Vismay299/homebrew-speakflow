cask "speakflow" do
  version "0.1.4"
  sha256 "7c895ab9251a4e478a98769567fb1223e1c9b2140dfff86fe43b2232d8e856f5"

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

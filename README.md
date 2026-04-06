# 🎬 SwiftUI Video Player (AVKit)

A SwiftUI app demonstrating how to play local and remote videos using AVKit's `VideoPlayer` view — covering playback controls, full-screen presentation, and basic player configuration.

---

## 🤔 What this is

This project shows how to embed a video player in a SwiftUI app using `AVKit`'s `VideoPlayer` view and `AVPlayer`. It demonstrates how to load a video from a URL, present it inline or full-screen, and control playback state from SwiftUI.

## ✅ Why you'd use it

- **VideoPlayer** — drop-in SwiftUI view for local and remote video playback
- **AVPlayer setup** — shows how to initialize `AVPlayer` with both asset URLs and remote streams
- **Playback control** — demonstrates play, pause, and seek using the player binding
- **Minimal setup** — no additional packages; uses native AVKit framework

## 📺 Watch on YouTube

[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/BGYxU4W8SGY)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@NoahDoesCoding97).

---

## 🚀 Getting Started

### 1. Clone the Repo
```bash
git clone https://github.com/NDCSwift/SwiftUI-Video-Player-AVKit-.git
cd SwiftUI-Video-Player-AVKit-
```

### 2. Open in Xcode
- Double-click `SwiftUI Video Player.xcodeproj`

### 3. Set Your Development Team
In Xcode: **TARGET → Signing & Capabilities → Team**

### 4. Update the Bundle Identifier
Change `com.example.MyApp` to a unique identifier (e.g., `com.yourname.VideoPlayer`).

---

## 🛠️ Notes

- To use a remote video URL, ensure `App Transport Security` settings allow the domain in Info.plist.
- If you see a code signing error, check that Team and Bundle ID are set.

## 📦 Requirements

- iOS 16+
- Xcode 15+
- Swift 5.9+

---

📺 [Watch the guide on YouTube](https://youtu.be/BGYxU4W8SGY)

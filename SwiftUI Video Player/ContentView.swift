//
// Project: SwiftUI Video Player
//  File: ContentView.swift
//  Created by Noah Carpenter
//  🐱 Follow me on YouTube! 🎥
//  https://www.youtube.com/@NoahDoesCoding97
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
//  Dream Big, Code Bigger

/// A simple example view that streams and plays a remote MP4 video.
/// Uses `AVPlayer` with SwiftUI's `VideoPlayer` to render playback.
/// Note: This creates a new player instance each access; for persistent control, store it in state.
///

import SwiftUI
import AVKit

struct ContentView: View {
    /// Player configured with a sample remote video URL (Big Buck Bunny).
    var player: AVPlayer {
        AVPlayer(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
    }
    
    /// The main view hierarchy displaying the video player at a fixed height.
    var body: some View {
        VideoPlayer(player: player)
            .frame(height: 300) // Constrain player height for layout consistency
            .padding() // Add outer spacing so the player isn't edge-to-edge
    }
}

#Preview {
    ContentView()
}


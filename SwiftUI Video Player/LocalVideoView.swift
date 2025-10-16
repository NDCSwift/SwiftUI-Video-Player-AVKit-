//
// Project: SwiftUI Video Player
//  File: LocalVideoView.swift
//  Created by Noah Carpenter
//  🐱 Follow me on YouTube! 🎥
//  https://www.youtube.com/@NoahDoesCoding97
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
//  Dream Big, Code Bigger

import SwiftUI
import AVKit

/// A minimal example that plays a bundled MP4 if available.
/// Falls back to an empty player when the resource is missing.
struct LocalVideoView: View {
    /// Player configured to load `local_video.mp4` from the app bundle.
    var player: AVPlayer {
        if let url = Bundle.main.url(forResource: "local_video", withExtension: "mp4") { // Look up the local video resource in the main bundle
            return AVPlayer(url: url) // Create player for the local file
        }
        return AVPlayer()
    }
    
    /// The view that renders the player with a fixed height.
    var body: some View {
        VideoPlayer(player: player)
            .frame(height: 300) // Keep consistent sizing across examples
    }
}

#Preview {
    LocalVideoView()
}

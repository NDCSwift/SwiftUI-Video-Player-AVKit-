//
// Project: SwiftUI Video Player
//  File: AdvancedVideoView.swift
//  Created by Noah Carpenter
//  🐱 Follow me on YouTube! 🎥
//  https://www.youtube.com/@NoahDoesCoding97
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Fun Fact: Cats have five toes on their front paws, but only four on their back paws! 🐾
//  Dream Big, Code Bigger

import SwiftUI
import AVKit
import AVFoundation


/// An advanced player view demonstrating local video playback with controls.
/// Shows how to mute/unmute and loop playback when the video ends.
/// Uses a dedicated `AVPlayer` stored in the view to maintain state.
struct AdvancedVideoView: View {
    @State private var isMuted: Bool = false  // Toggle to control player mute state
    @State private var endObserver: NSObjectProtocol? = nil  // Notification token for end-of-playback observer
    
    /// Backing AVPlayer for the `VideoPlayer` view.
    private var player: AVPlayer
    
    /// Initialize the player with a bundled video if available; otherwise, an empty player.
    init() {
        // Attempt to locate a video resource named "local_video_sound.mp4" in the app's main bundle.
        // - Bundle.main: The bundle that corresponds to the current app.
        // - url(forResource:withExtension:): Returns the file URL for a resource if it exists.
        if let url = Bundle.main.url(forResource: "local_video_sound", withExtension: "mp4") {
            // If the URL is found, initialize AVPlayer with that local file URL so it is ready to play.
            player = AVPlayer(url: url)
        } else {
            // If the resource cannot be found (e.g., missing file or wrong name/extension),
            // initialize an empty AVPlayer. This avoids crashes and lets the rest of the UI render.
            // Note: Without a valid item, the player will not display video until one is set.
            player = AVPlayer()
        }
    }
    
    /// The view layout with the video player and a mute toggle.
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .frame(height: 300)
                .onAppear {
                    player.isMuted = isMuted  // Apply current mute state
                    player.play()  // Start playback

                    // Avoid adding multiple observers
                    if endObserver == nil {
                        endObserver = NotificationCenter.default.addObserver(
                            forName: .AVPlayerItemDidPlayToEndTime,
                            object: player.currentItem,
                            queue: .main
                        ) { _ in
                            player.seek(to: .zero)  // Restart from beginning to loop
                            player.play()
                        }
                    }
                }
                .onDisappear {
                    if let token = endObserver {
                        NotificationCenter.default.removeObserver(token)
                        endObserver = nil
                    }
                    player.pause()  // Stop playback when view leaves screen
                }
            
            Toggle("Mute Video", isOn: $isMuted)  // UI control to switch audio on/off
                .padding()
                .onChange(of: isMuted) { newValue in  // Keep AVPlayer's mute state in sync with the toggle
                    player.isMuted = newValue
                }
        }
    }
}

#Preview {
    AdvancedVideoView()
}

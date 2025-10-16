//
// Project: SwiftUI Video Player
//  File: CustomizedVideoView.swift
//  Created by Noah Carpenter
//

import SwiftUI
import AVKit
import AVFoundation

/// A clean, single-view beveled video player suitable for reuse.
/// - Features:
///   - Minimal, fast-to-type-check styling with a subtle bezel.
///   - Accepts a local bundled resource or remote `URL`.
///   - Autoplays, loops, and starts muted

struct BeveledVideoPlayer: View {
    // MARK: - Inputs
    let player: AVPlayer
    let title: String?
    let subtitle: String?

    // MARK: - Internal state for looping
    @State private var endObserver: NSObjectProtocol? = nil

    // MARK: - Initializers
    /// Create with either a local bundled resource or a direct URL.
    /// Priority order: `url` > `localResource`.
    init(localResource: (name: String, ext: String)? = ("local_video", "mp4"),
         url: URL? = nil,
         title: String? = nil,
         subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle

        if let url = url {
            self.player = AVPlayer(url: url)
        } else if let resource = localResource,
                  let fileURL = Bundle.main.url(forResource: resource.name, withExtension: resource.ext) {
            self.player = AVPlayer(url: fileURL)
        } else {
            self.player = AVPlayer()
        }
    }

    // MARK: - View
    var body: some View {
        let bezelCorner: CGFloat = 28
        let screenCorner: CGFloat = 16

        ZStack {
            // Background gradient to help it pop on dark/thumbnail contexts
            LinearGradient(
                colors: [
                    Color(.sRGB, red: 0.07, green: 0.08, blue: 0.12, opacity: 1.0),
                    Color(.sRGB, red: 0.02, green: 0.02, blue: 0.04, opacity: 1.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Bezel
            RoundedRectangle(cornerRadius: bezelCorner, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.14), Color(white: 0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    // Outer border sheen
                    RoundedRectangle(cornerRadius: bezelCorner, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [Color.white.opacity(0.35), Color.white.opacity(0.05)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
                .shadow(color: Color.black.opacity(0.35), radius: 18, x: 0, y: 16)
                .shadow(color: Color.black.opacity(0.18), radius: 8, x: 8, y: 12)
                .padding(.horizontal)

            // Screen
            VideoPlayer(player: player)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: screenCorner, style: .continuous))
                .overlay(
                    // Subtle inner rim around the screen
                    RoundedRectangle(cornerRadius: screenCorner, style: .continuous)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
                .padding(14) // Bezel thickness
                .shadow(color: .blue.opacity(0.12), radius: 10, x: 0, y: 6)

           
        }
        .onAppear {
            player.isMuted = true
            player.play()

            if endObserver == nil {
                endObserver = NotificationCenter.default.addObserver(
                    forName: .AVPlayerItemDidPlayToEndTime,
                    object: player.currentItem,
                    queue: .main
                ) { _ in
                    player.seek(to: .zero)
                    player.play()
                }
            }
        }
        .onDisappear {
            if let token = endObserver {
                NotificationCenter.default.removeObserver(token)
                endObserver = nil
            }
            player.pause()
        }
    }
}

#Preview {
    BeveledVideoPlayer()
    .preferredColorScheme(.dark)
}

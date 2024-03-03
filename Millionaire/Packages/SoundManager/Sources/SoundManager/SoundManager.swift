// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import AVFoundation

public enum SoundType: String {
    case correct = "correctAnswer"
    case incorrect = "incorrectAnswer"
    case pauseUntilResult
//    case win = "playerWin"
    case timer = "timeOn"
    case start = "sound-start"
    case startGame = "sound-start-game"
    
    var sound: Data? {
        NSDataAsset(name: rawValue, bundle: .module)?.data
    }
}

public final class SoundManager: NSObject {
    public static let shared = SoundManager()
    private var player: AVAudioPlayer?
    
    public func play(_ type: SoundType) {
        guard let sound = type.sound else { return }
        do {
            player = try AVAudioPlayer(data: sound)
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func pause() {
        player?.pause()
    }
    
    public func stop() {
        player?.stop()
        player?.currentTime = 0
    }
}

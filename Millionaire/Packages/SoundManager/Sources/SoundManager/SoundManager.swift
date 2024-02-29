// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import AVFoundation

public enum SoundType: String {
    case correct = "correctAnswer"
    case incorrect = "incorrectAnswer"
    case pauseUntilResult
    case win = "playerWin"
    case timer = "timeOn"
}

public final class SoundManager {
    public static let shared = SoundManager()
    private var player: AVAudioPlayer?
    
    private init() {}
    
    public func play(filename: SoundType) {
        let name = filename.rawValue
        
        guard let data = NSDataAsset(name: name, bundle: .module)?.data else {
            print("Аудиофайл \(filename) не найден")
            return
        }
        
        do {
            player = try AVAudioPlayer(data: data)
            player?.play()
        } catch {
            print("Невозможности воспроизвести аудиофайл \(name)")
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

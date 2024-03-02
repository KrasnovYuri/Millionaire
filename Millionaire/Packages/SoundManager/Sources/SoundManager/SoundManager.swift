// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import AVFoundation

public protocol SoundManagerDelegate: AnyObject {
    func didFinishPlay()
    func didChangeSound(sound: SoundType)
}

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
    public weak var delegate: SoundManagerDelegate?
    public static let shared = SoundManager()
    private var player: AVAudioPlayer?
    
    public func play(_ type: SoundType) {
        guard let sound = type.sound else { return }
        do {
            player = try AVAudioPlayer(data: sound)
            player?.delegate = self
            player?.play()
            self.delegate?.didChangeSound(sound: type)
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

extension SoundManager: AVAudioPlayerDelegate {
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.didFinishPlay()
    }
}

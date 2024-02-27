// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import AVFoundation

public final class SoundManager {
    public static let shared = SoundManager()
    private var player: AVAudioPlayer?
    
    private init() {}
    
    private enum SoundError: Error {
        case notFound(name: String)
        case dontPlaying(name: String)
        
        var localize: String {
            switch self {
            case .notFound(let name):
                return "Аудиофайл \(name) не найден"
            case .dontPlaying(let name):
                return "Ошибка воспроизведения аудио: \(name)"
            }
        }
    }
    
    public func play(filename: String) throws {
        guard let data = NSDataAsset(name: filename, bundle: .module)?.data else {
            throw SoundError.notFound(name: filename)
        }
        
        do {
            player = try AVAudioPlayer(data: data)
            player?.play()
        } catch {
            throw SoundError.dontPlaying(name: filename)
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

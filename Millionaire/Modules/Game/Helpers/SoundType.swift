//
//  SoundType.swift
//  Millionaire
//
//  Created by Khusain on 27.02.2024.
//

import Foundation
import SoundManager

enum SoundType: String {
    case correct = "correctAnswer"
    case incorrect = "incorrectAnswer"
    case pauseUntilResult
    case win = "playerWin"
    case timer = "timeOn"
    
    func play() {
        do {
            try SoundManager.shared.play(filename: self.rawValue)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func pause() {
        SoundManager.shared.pause()
    }
    
    func stop() {
        SoundManager.shared.stop()
    }
}

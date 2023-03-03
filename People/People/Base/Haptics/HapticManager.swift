//
//  HapticManager.swift
//  People
//
//  Created by J on 2023-02-28.
//

import Foundation
import UIKit

fileprivate final class HapticManager {
    
    static let shared = HapticManager()
    
    private let feedback = UINotificationFeedbackGenerator()
    
    private init() {}
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(notification)
    }
}

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaultKeys.haptcisEnabled) {
        HapticManager.shared.trigger(notification)
    }
}

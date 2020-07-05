//
//  FeedbackGenerator.swift
//  Evain
//
//  Created by Jatin on 2020/07/02.
//

import SwiftUI

// MARK: - Extension View
extension View {
    
    // MARK: - Feedback Generator
    func generateFeedback(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let gen = UINotificationFeedbackGenerator()
        gen.notificationOccurred(type)
    }
}

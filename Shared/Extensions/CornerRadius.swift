//
//  CornerRadius.swift
//  Evain
//
//  Created by Jatin on 2020/07/02.
//

import SwiftUI

// MARK: - Extension View
extension View {
    // MARK: - Corner Radius
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

// MARK: - Rounded Corner
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

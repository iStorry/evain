//
//  LoadingView.swift
//  Evain
//
//  Created by Jatin on 2020/07/02.
//

import SwiftUI

struct LoadingView: View {
    @State private var shouldAnimate = false
    @State var leftOffset: CGFloat = -100
    @State var rightOffset: CGFloat = 100
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.black)
            .frame(width: 80, height: 20)
            .offset(x: shouldAnimate ? rightOffset : leftOffset)
            .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
            .onAppear {
                self.shouldAnimate = true
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}



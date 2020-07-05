//
//  PlayerView.swift
//  Evain
//
//  Created by Jatin on 2020/07/02.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    
    @Binding var data : [VideoData]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<data.count){ i in
                ZStack {
                    Player(player: data[i].player)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .offset(y: -5)
                }
            }
        }.onAppear {
            data[0].player.play()
            data[0].player.actionAtItemEnd = .none
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: data[0].player.currentItem, queue: .main) { (_) in
                data[0].replay = true
            }
        }
    }
}

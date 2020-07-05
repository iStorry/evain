//
//  Coordinator.swift
//  Evain
//
//  Created by Jatin on 2020/07/02.
//

import SwiftUI
import AVKit

class Coordinator : NSObject,UIScrollViewDelegate {
       
    var parent : PlayerScrollView
    var index = 0

    init(parent1 : PlayerScrollView) {
        parent = parent1
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currenrindex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
        if index != currenrindex {
            index = currenrindex
            for i in 0..<parent.data.count {
                // pausing all other videos...
                parent.data[i].player.seek(to: .zero)
                parent.data[i].player.pause()
            }
            // playing next video...
            parent.data[index].player.play()
            parent.data[index].player.actionAtItemEnd = .none
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: parent.data[index].player.currentItem, queue: .main) { [unowned self] _ in
                parent.data[index].replay = true
            }
        }
    }
}

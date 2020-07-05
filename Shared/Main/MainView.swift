//
//  MainView.swift
//  Evain
//
//  Created by Jatin on 2020/07/02.
//

import SwiftUI
import os
import AVKit
import Combine
import SwiftyUserDefaults

struct MainContainerView: View {
    @EnvironmentObject var verifyModel: SignatureViewModel
    
    var body: some View {
        VStack {
            verifyModel.resource.isLoading() {
                LoadingView()
            }
            verifyModel.resource.hasError() { error in
                //ErrorView(error: $0)
                Text(error.localizedDescription)
            }
            verifyModel.resource.hasResource() { data in
                MainView(networkModel: NetworkModel(signature: data.signature, verifyFp: data.verifyFp))
            }
        }.onAppear(perform: verifyModel.onAppear)
    }

}
struct MainView: View {
    
    @ObservedObject var networkModel: NetworkModel
    
    var body: some View {
        VStack {
            ZStack {
                if !self.networkModel.video.isEmpty {
                   PlayerScrollView(data: self.$networkModel.video)
                }
                VStack {
                    // MARK: - Top View
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "leaf.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .font(Font.title.weight(.heavy))
                                .foregroundColor(.white)
                            Spacer()

                            Button(action: {
                                generateFeedback(.success)
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .font(Font.title.weight(.heavy))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
                    Spacer()

                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.bottom, (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! + 5)
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

class Host : UIHostingController<SplashView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    /// ```
    /// Text("Label")
    ///     .isHidden(true)
    /// ```
    ///
    /// Example for complete removal:
    /// ```
    /// Text("Label")
    ///     .isHidden(true, remove: true)
    /// ```
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        modifier(HiddenModifier(isHidden: hidden, remove: remove))
    }
}


/// Creates a view modifier to show and hide a view.
///
/// Variables can be used in place so that the content can be changed dynamically.
fileprivate struct HiddenModifier: ViewModifier {

    private let isHidden: Bool
    private let remove: Bool

    init(isHidden: Bool, remove: Bool = false) {
        self.isHidden = isHidden
        self.remove = remove
    }

    func body(content: Content) -> some View {
        Group {
            if isHidden {
                if remove {
                    EmptyView()
                } else {
                    content.hidden()
                }
            } else {
                content
            }
        }
    }
}

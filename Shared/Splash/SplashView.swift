//
//  ContentView.swift
//  Shared
//
//  Created by Jatin on 2020/07/02.
//

import SwiftUI
import SwiftyUserDefaults

struct SplashView: View {
    
    @State var showMainView: Bool = Defaults[\.launched]

    var body: some View {
        
        // MARK: -  Main Stack
        VStack {
            if showMainView {
                MainContainerView().environmentObject(SignatureViewModel(with: EvianNetwork()))
            } else {
                // MARK: - Spacer
                Spacer()
                // MARK: - Logo View
                Image(systemName: "leaf.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 140)
                // MARK: - App Name
                if let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
                    Text(name)
                        .font(.largeTitle)
                        .bold()
                }
                // MARK: - Description
                Text("A reverse-engineered implementation of the TikTok app's API.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 40)
                
                // MARK: - Start Button
                Button(action: {
                    generateFeedback(.success)
                    showMainView = true
                    Defaults[\.launched] = true
                }) {
                    Text("Start")
                        .foregroundColor(.white)
                }
                .frame(width: 140, height: 40)
                .background(Color.black)
                .cornerRadius(40)
                
                // MARK: - Spacer
                Spacer()
                
                // MARK: - Author Text
                HStack {
                    Spacer()
                    Text("- Mew")
                        .foregroundColor(.gray)
                        .font(.caption)
                        .bold()
                        .padding(.trailing, 40)
                        .padding(.bottom, 20)

                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

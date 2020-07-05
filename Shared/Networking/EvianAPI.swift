//
//  EvianAPI.swift
//  Evain
//
//  Created by Jatin on 2020/07/02.
//

import Foundation
import Moya
import AVKit


enum APIError: Error {
    case noData
    case apiError
    case decodingError
    case noResponse

    var localizedDescription: String {
        switch self {
        case .noData:
            return "No Data"
        case .apiError:
            return "API Error"
        case .decodingError:
            return "Decoding Error"
        case .noResponse:
        return "No Response"
        }
    }
}

enum EvianAPI {
    case items(Int, String, String)
}

extension EvianAPI: TargetType {

    var baseURL: URL { return URL(string: "https://t.tiktok.com/api")! }
    
    var path: String {
        switch self {
        
        case .items:
            return "/item_list/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        
        case .items:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .items(let count, let signature, let verifyFp):
            return .requestParameters(parameters: [
                "count": 30,
                "id": 1,
                "type": 5,
                "secUid": "",
                "maxCursor": 1,
                "minCursor": 0,
                "sourceType": 12,
                "appId": 1233,
                "verifyFp": verifyFp,
                "_signature": signature
            ], encoding: URLEncoding.default)
        }
    }
    var headers: [String: String]? {
        return nil
    }
    
}


class NetworkModel: ObservableObject {
    @Published var video = [VideoData]()
    
    init(data: [VideoData] = [], signature: String, verifyFp: String) {
        getFeed(signature: signature, verifyFp: verifyFp)
    }
    
    private func getFeed(signature: String, verifyFp: String) {
        let provider = MoyaProvider<EvianAPI>()
        print(signature)
        print(verifyFp)
        provider.request(.items(Fields.count, signature, verifyFp)) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let result = try JSONDecoder().decode(Main.self, from: response.data)
                    for data in result.items {
                        if let url = URL(string: data.video.playAddr) {
                            self?.video.append(VideoData(player: AVPlayer(url: url), replay: false))
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                    self?.video = []
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.video = []
            }
        }
    }
}

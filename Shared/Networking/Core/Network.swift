//
//  Network.swift
//  SMW UI
//
//  Created by Jatin on 2020/07/01.
//

import Foundation
import Combine

protocol Network {

    var decoder: JSONDecoder { get set }
    var enviroment: NetworkEnvironment { get set }
}

extension Network {

    func fetch<T: Decodable>(route: NetworkRoute, with data: Data?) -> AnyPublisher<T, Error> {
        let request = route.create(for: enviroment, with: data)
        return URLSession.shared.dataTaskPublisher(for: request).tryCompactMap { result in
            try self.decoder.decode(T.self, from: result.data)
        }.receive(on: RunLoop.main).eraseToAnyPublisher()
    }
}

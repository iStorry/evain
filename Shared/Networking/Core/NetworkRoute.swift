//
//  NetworkRoute.swift
//  SMW UI
//
//  Created by Jatin on 2020/07/01.
//

import Foundation

protocol NetworkRoute {

    var path: String { get }
    var method: NetworkMethod { get }
    var headers: [String: String]? { get }
}

extension NetworkRoute {

    var headers: [String : String]? {
        return nil
    }

    func create(for enviroment: NetworkEnvironment, with data: Data? = nil) -> URLRequest {

        var request = URLRequest(url: URL(string: enviroment.rawValue + path)!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue.uppercased()
        if data != nil {
            request.httpBody = data
        }
        return request
    }
}

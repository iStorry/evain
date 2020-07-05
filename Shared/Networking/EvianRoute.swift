//
//  SMWRoute.swift
//  Evain
//
//  Created by Jatin on 2020/07/02.
//

import Foundation

enum EvianRoute {
    case signature
}

extension EvianRoute: NetworkRoute {

    var path: String {
        switch self {
        case .signature:
            return "/signature"
        }
    }

    var method: NetworkMethod {
        switch self {
        case .signature:
            return .post
        }
    }
    
    
}

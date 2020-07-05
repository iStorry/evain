//
//  EvianNetwork.swift
//  Evain
//
//  Created by Jatin on 2020/07/02.
//

import Foundation

struct EvianNetwork: Network {
    var enviroment: NetworkEnvironment = .host
    var decoder: JSONDecoder = JSONDecoder()
}


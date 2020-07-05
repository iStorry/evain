//
//  Verify.swift
//  Evain
//
//  Created by Jatin on 2020/07/02.
//

import Foundation
import Combine

struct Signature: Codable {
    let signature: String
    let verifyFp: String
}

class SignatureViewModel: NetworkViewModel, ObservableObject {
    typealias NetworkResource = Signature
    
    var resource: Resource<NetworkResource> = .loading
    var network: Network
    var route: NetworkRoute = EvianRoute.signature
    var bag: Set<AnyCancellable> = Set<AnyCancellable>()
    init(with network: Network) {
        self.network = network
    }
}

protocol NetworkViewModel: ObservableObject {

    associatedtype NetworkResource: Decodable

    var objectWillChange: ObservableObjectPublisher { get }
    var resource: Resource<NetworkResource> { get set }
    var network: Network { get set }
    var route: NetworkRoute { get }
    var bag: Set<AnyCancellable> { get set }

    func onAppear()
}

extension NetworkViewModel {

    func fetch(route: NetworkRoute) {

        (network.fetch(route: route, with: EvianSignature.feed.rawValue.data(using: .utf8)) as AnyPublisher<NetworkResource, Error>)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.resource = .error(error)
                    self.objectWillChange.send()
                default:
                    break
                }
            }, receiveValue: { decodable in
                self.resource = .success(decodable)
                self.objectWillChange.send()
            })
            .store(in: &bag)
    }

    func onAppear() {
        fetch(route: route)
    }
}

//
//  RSwiftListingsLoader.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-09.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

protocol RSwiftListingsLoading {
    func swiftListings(after: String?, completion: @escaping (Result<ListingsResponse, Error>) -> Void)
}

struct RSwiftListingsLoader: RSwiftListingsLoading {
    let engine: APIRequesting = URLSessionEngine(completionQueue: .main)

    func swiftListings(after: String?, completion: @escaping (Result<ListingsResponse, Error>) -> Void) {
        engine.performRequest(router: RSwiftEndpoint.swiftListings(after: after), completion: completion)
    }
}

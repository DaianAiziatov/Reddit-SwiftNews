//
//  APIRequesting.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-08.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

protocol APIRequesting {
    func performRequest<T: Codable, V: APIRouting>(router: V,
                                                   configuration: NetworkConfiguration,
                                                   completion: ((Result<T, Error>) -> Void)?)
    func performRequest<T: Codable, V: APIRouting>(router: V,
                                                   completion: ((Result<T, Error>) -> Void)?)
}

extension APIRequesting {
    func performRequest<T: Codable, V: APIRouting>(router: V,
                                                   completion: ((Result<T, Error>) -> Void)?) {
        performRequest(router: router,
                       configuration: NetworkConfiguration.default,
                       completion: completion)
    }
}

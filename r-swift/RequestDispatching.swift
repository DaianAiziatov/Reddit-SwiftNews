//
//  RequestDispatching.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-08.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

protocol RequestDispatching {
    typealias RequestDispatcherCompletion = (Data?, Error?, HTTPURLResponse?) -> Void

    func dispatch<T: APIRouting>(_ router: T,
                                 configuration: NetworkConfiguration,
                                 completion: @escaping RequestDispatcherCompletion)
    func dispatch<T: APIRouting>(_ router: T,
                                 completion: @escaping RequestDispatcherCompletion)
}

extension RequestDispatching {
    func dispatch<T: APIRouting>(_ router: T,
                                 completion: @escaping RequestDispatcherCompletion) {
        dispatch(router, configuration: NetworkConfiguration.default, completion: completion)
    }
}

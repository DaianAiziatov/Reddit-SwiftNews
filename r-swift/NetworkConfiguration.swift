//
//  NetworkConfiguration.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-08.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

struct NetworkConfiguration {
    static let `default`: NetworkConfiguration = NetworkConfiguration(timeoutInterval: 8.0,
                                                                      basePath: "https://www.reddit.com/")
    let timeoutInterval: TimeInterval
    let basePath: String
}

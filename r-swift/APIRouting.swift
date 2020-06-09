//
//  APIRouting.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-08.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

protocol QueryItemProviding {
    var queryItems: [URLQueryItem] { get }
}

protocol APIRouting: Hashable {
    var method: APIHTTPMethod { get }
    var path: String { get }
}

extension APIRouting {
    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
        hasher.combine(method)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.path == rhs.path && lhs.method == rhs.method
    }
}

//
//  RSwiftEndpoint.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-08.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

enum RSwiftEndpoint: APIRouting, QueryItemProviding {
    case swiftListings(after: String?)

    var path: String {
        switch self {
        case .swiftListings:
            return "r/swift/.json"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {
        case let .swiftListings(.some(after)):
            return [URLQueryItem(name: "after", value: "\(after)")]
        case .swiftListings(after: .none):
            return []
        }
    }

    var method: APIHTTPMethod {
        switch self {
        case .swiftListings:
            return .get
        }
    }
}

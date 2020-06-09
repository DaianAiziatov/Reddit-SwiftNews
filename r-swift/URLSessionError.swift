//
//  URLSessionError.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-08.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

enum URLSessionError: Error {
    case invalidURL
    case invalidData
    case encodingFailed
    case general
}

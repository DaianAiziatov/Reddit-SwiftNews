//
//  Listing.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-09.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

struct ListingData: Decodable {
    let title: String
    // FIXME: Non optional might be self or default
    let thumbnail: String?
    let url: String?
    let score: Int
}

//
//  Listings.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-09.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

struct Listings: Decodable {
    let children: [ListingData]
    let after: String?
}

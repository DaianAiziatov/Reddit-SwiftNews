//
//  ListingsResponse.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-08.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

struct ListingsResponse {
    let listings: [ListingData]
    let after: String?

    enum CodingKeys: String, CodingKey {
        case data
    }

    enum ListingsDataCodingKeys: String, CodingKey {
        case children, after
    }
}

extension ListingsResponse: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let listingsData = try values.nestedContainer(keyedBy: ListingsDataCodingKeys.self, forKey: .data)
        listings = try listingsData.decode([Listing].self, forKey: .children).map { $0.data }
        after = try listingsData.decode(String.self, forKey: .after)
    }
}

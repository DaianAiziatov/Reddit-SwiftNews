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
    let thumbnail: String
    let thumbnailHeight: Int?
    let url: String?
    let score: Int
    let selftext: String?
    let numberOfComments: Int

    var isValidThumbnailUrl: Bool {
        return thumbnail != "self" && thumbnail != "default"
    }

    private enum CodingKeys: String, CodingKey {
        case title,
        thumbnail,
        url,
        score,
        selftext,
        numberOfComments = "num_comments",
        thumbnailHeight = "thumbnail_height"
    }
}

//
//  ListingDetailsViewModel.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-10.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

final class ListingDetailsViewModel {
    private(set) var listing: ListingData

    var title: String {
        listing.title
    }

    var text: String? {
        listing.selftext
    }

    var thumbnailURL: URL? {
        guard listing.isValidThumbnailUrl,
            let url = URL(string: listing.thumbnail) else {
            return nil
        }
        return url
    }

    var webVersionURL: URL? {
        guard let webVersionURLString = listing.url,
            let webVersionURL = URL(string: webVersionURLString) else {
            return nil
        }
        return webVersionURL
    }

    init(listing: ListingData) {
        self.listing = listing
    }
}

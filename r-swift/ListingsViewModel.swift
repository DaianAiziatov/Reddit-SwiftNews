//
//  ListingsViewModel.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-09.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

protocol ListingsViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class ListingsViewModel {
    weak var delegate: ListingsViewModelDelegate?

    private var listings: [ListingData] = []
    private var isFetchInProgress = false
    private let listingLoader: RSwiftListingsLoading
    private var after: String?

    init(listingLoader: RSwiftListingsLoading = RSwiftListingsLoader()) {
        self.listingLoader = listingLoader
    }

    var currentCount: Int {
        return listings.count
    }

    var total: Int {
        return listings.count + 25
    }

    func listing(at index: Int) -> ListingData? {
        return listings[safe: index]
    }

    func fetchListings() {
        guard !isFetchInProgress else {
            return
        }

        isFetchInProgress = true

        listingLoader.swiftListings(after: after) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.isFetchInProgress = false
                self?.delegate?.onFetchFailed(with: error.localizedDescription)
            case .success(let response):
                self?.isFetchInProgress = false
                self?.listings.append(contentsOf: response.listings)
                if self?.after != nil {
                    let indexPathsToReload = self?.calculateIndexPathsToReload(from: response.listings)
                    self?.delegate?.onFetchCompleted(with: indexPathsToReload)
                } else {
                    self?.delegate?.onFetchCompleted(with: .none)
                }
                self?.after = response.after
            }
        }
    }

    private func calculateIndexPathsToReload(from newListings: [ListingData]) -> [IndexPath] {
        let startIndex = listings.count - newListings.count
        let endIndex = startIndex + newListings.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

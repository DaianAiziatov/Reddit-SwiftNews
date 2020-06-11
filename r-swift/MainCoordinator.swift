//
//  MainCoordinator.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-10.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    func start() {
        let listingsViewModel = ListingsViewModel()
        let listingsController = ListingsViewController(title: "Swift News", viewModel: listingsViewModel, onSelectListing: showListingDetails)

        navigationController.pushViewController(listingsController, animated: false)
    }

    func showListingDetails(listing: ListingData) {
        let listingDetailsViewModel = ListingDetailsViewModel(listing: listing)
        let detailsController = ListingDetailsViewController(viewModel: listingDetailsViewModel)
        navigationController.pushViewController(detailsController, animated: true)
    }
}

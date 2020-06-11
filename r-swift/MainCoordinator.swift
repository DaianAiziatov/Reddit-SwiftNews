//
//  MainCoordinator.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-10.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let listingsViewModel = ListingsViewModel()
        let listingsController = ListingsViewController(title: "Swift News", viewModel: listingsViewModel, onSelectListing: showListingDetails)

        navigationController.pushViewController(listingsController, animated: false)
    }

    private func showListingDetails(listing: ListingData) {
        let listinDetailsCoordinator = ListingDetailsCoordinator(navigationController: navigationController, listing: listing)
        childCoordinators.append(listinDetailsCoordinator)
        listinDetailsCoordinator.parentCoordinator = self
        listinDetailsCoordinator.start()
    }
}

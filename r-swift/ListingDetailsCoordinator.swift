//
//  ListingDetailsCoordinator.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-10.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import UIKit

class ListingDetailsCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: Coordinator?

    private let listing: ListingData

    init(navigationController: UINavigationController, listing: ListingData) {
        self.navigationController = navigationController
        self.listing = listing
    }

    func start() {
        let listingDetailsViewModel = ListingDetailsViewModel(listing: listing)
        let detailsController = ListingDetailsViewController(viewModel: listingDetailsViewModel,
                                                             onNavigateBack: didNavigateBack,
                                                             onTapShowWebVersion: showWebView)
        navigationController.pushViewController(detailsController, animated: true)
    }

    private func didNavigateBack() {
        parentCoordinator?.childDidFinish(self)
    }

    private func showWebView(with url: URL) {
        let webController = WebViewController(urlToOpen: url)
        if #available(iOS 13.0, *) {
        } else {
            webController.modalTransitionStyle = .coverVertical
            webController.modalPresentationStyle = .overFullScreen
            webController.modalPresentationCapturesStatusBarAppearance = true
        }
        navigationController.present(webController, animated: true)
    }
}

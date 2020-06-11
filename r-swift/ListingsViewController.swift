//
//  ViewController.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-08.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import UIKit

class ListingsViewController: UIViewController, AlertDisplayable {

    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView()

    let viewModel: ListingsViewModel

    init(viewModel: ListingsViewModel, title: String) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupActivityIndicator()
        refreshControl.addTarget(self, action: #selector(refresh), for: .allEvents)
        navigationController?.navigationBar.prefersLargeTitles = true

        viewModel.fetchListings()
    }

    @objc
    private func refresh() {
        viewModel.refresh()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.embed(in: view)
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ListingTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.refreshControl = refreshControl
        tableView.isHidden = true
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center(in: view)
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

    }
}

extension ListingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListingTableViewCell else {
            fatalError("Unregistered cell")
        }
        cell.configure(with: viewModel.listing(at: indexPath.row))
        return cell
    }
}

extension ListingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let listing = viewModel.listing(at: indexPath.row) else {
            return
        }
        let listingDetailsViewModel = ListingDetailsViewModel(listing: listing)
        let detailsController = ListingDetailsViewController(viewModel: listingDetailsViewModel)
        navigationController?.pushViewController(detailsController, animated: true)
    }
}

extension ListingsViewController: ListingsViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            tableView.isHidden = false
            activityIndicator.stopAnimating()
            tableView.reloadData()
            refreshControl.endRefreshing()
            return
        }
        tableView.insertRows(at: newIndexPathsToReload, with: .automatic)
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }

    func onFetchFailed(with reason: String) {
        let title = "Warning"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title, message: reason, actions: [action])
    }
}

extension ListingsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchListings()
        }
    }
}

private extension ListingsViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount - 25 // default count repsonse for API
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}

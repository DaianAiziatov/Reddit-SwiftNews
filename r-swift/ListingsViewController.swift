//
//  ViewController.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-08.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import UIKit

class ListingsViewController: UIViewController {

    let tableView = UITableView()

    var listings = [ListingData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchListings()
    }

    override func loadView() {
        super.loadView()
        setupTableView()
    }

    private func fetchListings() {
        RSwiftListingsLoader().swiftListings(after: nil) { result in
            switch result {
            case let .success(response):
                self.listings.append(contentsOf: response.listings)
                self.tableView.reloadData()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ListingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listings[indexPath.row].title
        return cell
    }
}

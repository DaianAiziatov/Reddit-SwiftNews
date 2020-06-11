//
//  ListingDetailsViewController.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-10.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import UIKit

class ListingDetailsViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private var thumbImageView: UIImageView!
    private var textTextView: UITextView!
    private var openWebViewButton: UIButton!

    private var viewModel: ListingDetailsViewModel

    init(viewModel: ListingDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.embed(in: view)
        scrollView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        setupViews()
    }

    private func setupViews() {
        title = viewModel.title

        scrollView.addSubview(contentStackView)
        contentStackView.alignment = .center
        contentStackView.axis = .vertical
        contentStackView.spacing = 10
        contentStackView.embed(in: scrollView)
        contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        if let thumbnailURL = viewModel.thumbnailURL {
            thumbImageView = UIImageView()
            thumbImageView.contentMode = .center
            contentStackView.addArrangedSubview(thumbImageView)
            thumbImageView.backgroundColor = .white
            thumbImageView?.loadImage(from: thumbnailURL)
        }

        if viewModel.text?.isEmpty == false {
            textTextView = UITextView()
            contentStackView.addArrangedSubview(textTextView)
            textTextView.isScrollEnabled = false
            textTextView.font = UIFont.systemFont(ofSize: 15)
            textTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            textTextView.text = viewModel.text
            textTextView.backgroundColor = .white
        }

        if viewModel.webVersionURL != nil {
            openWebViewButton = UIButton()
            openWebViewButton.setTitle("Open Web Version", for: .normal)
            openWebViewButton.tintColor = .black
            contentStackView.addArrangedSubview(openWebViewButton)
            openWebViewButton.addTarget(self, action: #selector(openWebView), for: .touchUpInside)
        }
    }

    @objc
    private func openWebView() {
        guard let webVersionURL = viewModel.webVersionURL else {
            assertionFailure("Previously checked webVersionURL is missed")
            return
        }
        let webController = WebViewController(urlToOpen: webVersionURL)
        navigationController?.present(webController, animated: true)
    }
}

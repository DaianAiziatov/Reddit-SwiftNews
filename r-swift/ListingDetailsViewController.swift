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
    private var onNavigateBack: () -> Void
    private var onTapShowWebVersion: (URL) -> Void

    init(viewModel: ListingDetailsViewModel,
         onNavigateBack: @escaping () -> Void,
         onTapShowWebVersion: @escaping (URL) -> Void) {
        self.viewModel = viewModel
        self.onNavigateBack = onNavigateBack
        self.onTapShowWebVersion = onTapShowWebVersion
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        view.backgroundColor = .white
        title = viewModel.title

        setupScrollView()
        setupContentStackView()
        setupThumbnailImageView()
        setupTextView()
        setupOpenWebViewButton()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onNavigateBack()
    }

    private func setupScrollView() {
        scrollView.embed(in: view)
        scrollView.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }

    private func setupContentStackView() {
        scrollView.addSubview(contentStackView)
        contentStackView.alignment = .center
        contentStackView.axis = .vertical
        contentStackView.spacing = 10
        contentStackView.embed(in: scrollView)
        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

    private func setupThumbnailImageView() {
        if let thumbnailURL = viewModel.thumbnailURL {
            thumbImageView = UIImageView()
            thumbImageView.contentMode = .center
            contentStackView.addArrangedSubview(thumbImageView)
            thumbImageView?.loadImage(from: thumbnailURL)
        }
    }

    private func setupTextView() {
        textTextView = UITextView()
        contentStackView.addArrangedSubview(textTextView)
        textTextView.isScrollEnabled = false
        textTextView.font = UIFont.systemFont(ofSize: 15)
        textTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        if viewModel.text?.isEmpty == false {
            textTextView.text = viewModel.text
            textTextView.backgroundColor = .white
        } else if viewModel.thumbnailURL == nil {
            textTextView.text = "Sorry, no content for this arcticle. Try web version."
            textTextView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        } else {
            textTextView.isHidden = true
        }
    }

    private func setupOpenWebViewButton() {
        if viewModel.webVersionURL != nil {
            openWebViewButton = UIButton()
            openWebViewButton.setTitle("Open Web Version", for: .normal)
            openWebViewButton.setTitleColor(.black, for: .normal)
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
        onTapShowWebVersion(webVersionURL)
    }
}

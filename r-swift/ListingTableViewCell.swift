//
//  ListingTableViewCell.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-09.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import UIKit

class ListingTableViewCell: UITableViewCell {

    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let thumbImageView = UIImageView()
    private let upVotesIconImageView = UIImageView(image: UIImage(named: "arrow_up"))
    private let downVotesIconImageView = UIImageView(image: UIImage(named: "arrow_down"))
    private let commentsIconImageView = UIImageView(image: UIImage(named: "comments"))
    private let scoresLabel = UILabel()
    private let numberOfCommentsLabel = UILabel()
    private let indicatorView = UIActivityIndicatorView()

    private var scoresStackView: UIStackView!
    private var commentsStackView: UIStackView!

    private var thumbImageViewHeightContraint: NSLayoutConstraint?
    private var thumbImageViewTopConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(white: 0.9, alpha: 1)
        selectionStyle = .none
        setupContainerView()
        setupTitleLabel()
        setupThumbnailImageView()
        setupIndicatorView()
        setupScoresView()
        setupCommentsView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }

    func configure(with listing: ListingData?) {
        guard let listing = listing else {
            setupForReuse()
            return
        }
        scoresStackView.isHidden = false
        commentsStackView.isHidden = false
        indicatorView.isHidden = true
        titleLabel.text = listing.title
        numberOfCommentsLabel.text = "\(listing.numberOfComments)"
        scoresLabel.text = "\(listing.score)"
        if listing.isValidThumbnailUrl,
            let url = URL(string: listing.thumbnail),
            let height = listing.thumbnailHeight {
            thumbImageViewHeightContraint = thumbImageView.heightAnchor.constraint(equalToConstant: CGFloat(height))
            thumbImageViewHeightContraint?.priority = .defaultHigh
            thumbImageViewHeightContraint?.isActive = true
            thumbImageViewTopConstraint?.constant = 15
            indicatorView.startAnimating()
            thumbImageView.loadImage(from: url) { _ in
                DispatchQueue.main.async {
                    self.indicatorView.stopAnimating()
                }
            }
        } else {
            thumbImageViewTopConstraint?.constant = 0
        }
    }

    private func setupForReuse() {
        thumbImageView.image = nil
        titleLabel.text = nil
        thumbImageViewHeightContraint?.isActive = false
        thumbImageViewTopConstraint?.constant = 0
        scoresStackView.isHidden = true
        commentsStackView.isHidden = true
    }

    private func setupContainerView() {
        addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.embed(in: self, paddingTop: 10, paddingBottom: 10)
    }

    private func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.anchor(top: containerView.topAnchor,
                          left: containerView.leftAnchor,
                          right: containerView.rightAnchor,
                          paddingTop: 15,
                          paddingLeft: 15,
                          paddingRight: 15)
    }

    private func setupThumbnailImageView() {
        containerView.addSubview(thumbImageView)
        thumbImageView.contentMode = .scaleAspectFit
        thumbImageView.anchor(left: containerView.leftAnchor,
                              right: containerView.rightAnchor)
        thumbImageViewTopConstraint = thumbImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15)
        thumbImageViewTopConstraint?.isActive = true
    }

    private func setupIndicatorView() {
        containerView.addSubview(indicatorView)
        indicatorView.center(in: thumbImageView)
        indicatorView.hidesWhenStopped = true
    }

    private func setupScoresView() {
        containerView.addSubview(upVotesIconImageView)
        upVotesIconImageView.contentMode = .scaleAspectFit

        containerView.addSubview(downVotesIconImageView)
        downVotesIconImageView.contentMode = .scaleAspectFit

        containerView.addSubview(scoresLabel)
        scoresLabel.font = UIFont.systemFont(ofSize: 10)

        scoresStackView = UIStackView(arrangedSubviews: [upVotesIconImageView, scoresLabel, downVotesIconImageView])
        scoresStackView.distribution = .equalSpacing
        scoresStackView.axis = .horizontal
        scoresStackView.spacing = 5
        containerView.addSubview(scoresStackView)
        scoresStackView.anchor(top: thumbImageView.bottomAnchor,
                               left: containerView.leftAnchor,
                               bottom: containerView.bottomAnchor,
                               paddingTop: 15,
                               paddingLeft: 15,
                               paddingBottom: 15,
                               height: 15)

    }

    private func setupCommentsView() {
        containerView.addSubview(commentsIconImageView)
        commentsIconImageView.contentMode = .scaleAspectFit

        containerView.addSubview(numberOfCommentsLabel)
        numberOfCommentsLabel.font = UIFont.systemFont(ofSize: 10)

        commentsStackView = UIStackView(arrangedSubviews: [commentsIconImageView, numberOfCommentsLabel])
        commentsStackView.distribution = .equalSpacing
        commentsStackView.axis = .horizontal
        commentsStackView.spacing = 5
        containerView.addSubview(commentsStackView)
        commentsStackView.anchor(top: thumbImageView.bottomAnchor,
                                 bottom: containerView.bottomAnchor,
                                 right: containerView.rightAnchor,
                                 paddingTop: 15,
                                 paddingBottom: 15,
                                 paddingRight: 15,
                                 height: 15)
    }
}

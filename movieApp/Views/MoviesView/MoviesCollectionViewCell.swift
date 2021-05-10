//
//  MoviesCollectionViewCell.swift
//  movieApp
//
//  Created by Maksym Bordyugov on 08.05.2021.
//  Copyright © 2021 Maksym Bordyugov. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var posterImage: CustomImageView!

    // MARK: - Object lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.numberOfLines = 2
    }

    // MARK: - Setup

    func setupCell(with movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseYear
        posterImage.loadImageUsing(path: movie.smallPosterPath)
    }
}

//
//  MoviesCollectionCell.swift
//  MovieDatabase
//
//  Created by Anton Komin on 19.05.2018.
//  Copyright © 2018 Anton Komin. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesCollectionCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            updateMovieInfo()
        }
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateMovieInfo() {
        if let movie = movie {
            ratingLabel.text = "\(String(format:"%.1f", movie.voteAvarage))"
            titleLabel.text = movie.title + (movie.releaseDate != nil ? "(\(dateFormatter.string(from: movie.releaseDate!)))" : "")
            posterImageView.sd_setImage(with: movie.posterURL, placeholderImage: #imageLiteral(resourceName: "posterPlaceholder"), options: .highPriority, progress: nil, completed: nil)
        } else {
            ratingLabel.text = nil
            titleLabel.text = " - "
            posterImageView.image = #imageLiteral(resourceName: "posterPlaceholder")
        }
    }

}

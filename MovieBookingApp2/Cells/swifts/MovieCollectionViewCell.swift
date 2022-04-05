//
//  MovieCollectionViewCell.swift
//  MovieBookingApp2
//
//  Created by kira on 16/02/2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var data: MovieVO? {
        didSet {
            if let data = data {
                let posterPath = AppConstants.basePosterUrl.appending(data.posterPath)
                posterImageView.sd_setImage(with: URL(string: posterPath))
                titleLabel.text = data.originalTitle
                let genres = data.genres
                if genres.count > 1 {
                    subtitleLabel.text = genres[0].appending("/ ").appending(genres[1])
                } else {
                    subtitleLabel.text = genres[0]
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

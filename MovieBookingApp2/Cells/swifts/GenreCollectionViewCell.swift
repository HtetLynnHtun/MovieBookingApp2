//
//  GenreCollectionViewCell.swift
//  MovieBookingApp2
//
//  Created by kira on 21/02/2022.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var labelGenreTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindData(genreTitle: String) {
        labelGenreTitle.text = genreTitle
    }
}

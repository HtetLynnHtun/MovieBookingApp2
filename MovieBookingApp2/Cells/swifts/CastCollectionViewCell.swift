//
//  CastCollectionViewCell.swift
//  MovieBookingApp2
//
//  Created by kira on 21/02/2022.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castImageView: UIImageView!
    
    var data: CastVO? {
        didSet {
            if let data = data,
               data.profilePath != nil {
                let profilePath = AppConstants.basePosterUrl.appending(data.profilePath!)
                castImageView.sd_setImage(with: URL(string: profilePath))
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

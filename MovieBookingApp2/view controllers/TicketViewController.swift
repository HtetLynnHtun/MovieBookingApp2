//
//  TicketViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import UIKit

class TicketViewController: UIViewController {

    @IBOutlet weak var imageViewPoster: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageViewPoster.clipsToBounds = true
        imageViewPoster.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageViewPoster.layer.cornerRadius = 16
    }
    
}

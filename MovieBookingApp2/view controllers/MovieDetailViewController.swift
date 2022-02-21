//
//  MovieDetailViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 21/02/2022.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var viewCornerOverlay: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewCornerOverlay.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewCornerOverlay.layer.cornerRadius = 16
        
    }

}

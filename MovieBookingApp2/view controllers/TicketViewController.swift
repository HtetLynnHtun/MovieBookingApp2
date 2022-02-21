//
//  TicketViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import UIKit

class TicketViewController: UIViewController {

    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var viewShadow: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestureRecognizers()
//        setupShadow()
        setupCornerRadius()
    }
    
    private func setupGestureRecognizers() {
        let buttonCloseTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapClose))
        buttonClose.addGestureRecognizer(buttonCloseTapGestureRecognizer)
    }
    
    @objc func didTapClose() {
        navigateToScreen(withIdentifier: HomeViewController.identifier)
    }
    
    private func setupCornerRadius() {
        imageViewPoster.clipsToBounds = true
        imageViewPoster.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageViewPoster.layer.cornerRadius = 16
    }
    
    private func setupShadow() {
//        viewShadow.layer.masksToBounds = false
        viewShadow.layer.shadowColor = UIColor.black.cgColor
        viewShadow.layer.shadowOpacity = 1
        viewShadow.layer.shadowOffset = .zero
        viewShadow.layer.shadowRadius = 5
        
//        viewShadow.layer.shouldRasterize = true
//        viewShadow.layer.rasterizationScale = UIScreen.main.scale
    }
    
}

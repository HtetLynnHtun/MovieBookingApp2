//
//  TicketViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import UIKit

class TicketViewController: UIViewController {

    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var bookingNoLabel: UILabel!
    @IBOutlet weak var showTimeDateLabel: UILabel!
    @IBOutlet weak var cinemaNameLabel: UILabel!
    @IBOutlet weak var ticketCountLabel: UILabel!
    @IBOutlet weak var rowLabel: UILabel!
    @IBOutlet weak var seatsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var courier: CourierVO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let goHomeButton = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(didTapGoHome))
        goHomeButton.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 24, weight: .bold)], for: .normal)
        navigationItem.leftBarButtonItem = goHomeButton
        
        initView()
        setupShadow()
        setupCornerRadius()
    }
    
    private func initView() {
        movieNameLabel.text = courier.movieName
        bookingNoLabel.text = courier.bookingNo
    }
    
    @objc private func didTapGoHome() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupCornerRadius() {
        imageViewPoster.clipsToBounds = true
        imageViewPoster.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageViewPoster.layer.cornerRadius = 16
    }
    
    private func setupShadow() {
        // if viewShadow don't have background color, shadows are also applied
        // to it's subbviews
        viewShadow.layer.backgroundColor = UIColor.white.cgColor
        viewShadow.clipsToBounds = true
        viewShadow.layer.cornerRadius = 16
        
        viewShadow.layer.masksToBounds = false
        viewShadow.layer.shadowColor = UIColor.black.cgColor
        viewShadow.layer.shadowOpacity = 0.2
        viewShadow.layer.shadowOffset = .zero
        viewShadow.layer.shadowRadius = 10
        
        // shadow is expensive, so cache it
        viewShadow.layer.shouldRasterize = true
        viewShadow.layer.rasterizationScale = UIScreen.main.scale
    }
    
}

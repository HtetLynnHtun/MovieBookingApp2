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
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
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
        let posterPath = AppConstants.basePosterUrl.appending(courier.posterPath)
        imageViewPoster.sd_setImage(with: URL(string: posterPath))
        movieNameLabel.text = courier.movieName
        bookingNoLabel.text = courier.bookingNo
        runtimeLabel.text = "\(courier.runtime)m - IMAX"
        showTimeDateLabel.text = "\(courier.time) \(courier.readableDate)"
        cinemaNameLabel.text = courier.cinemaName
        ticketCountLabel.text = "\(courier.seatNumber.split(separator: ",").count)"
        rowLabel.text = courier.row
        seatsLabel.text = courier.seatNumber.split(separator: ",").map { $0.suffix(1) }.joined(separator: ",")
        priceLabel.text = "$\(courier.totalPrice)"
        let qrImagePath = "https://tmba.padc.com.mm/\(courier.qrCode)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        qrCodeImageView.sd_setImage(with: URL(string: qrImagePath))
    }
    
    @objc private func didTapGoHome() {
        let homeVC = self.navigationController?.viewControllers.filter { $0 is HomeViewController }.first
        self.navigationController?.popToViewController(homeVC!, animated: false)
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

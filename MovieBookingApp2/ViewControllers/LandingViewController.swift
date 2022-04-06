//
//  LandingViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var buttonGetStarted: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonGetStarted.layer.cornerRadius = 8
        buttonGetStarted.layer.borderWidth = 0.5
        buttonGetStarted.layer.borderColor = UIColor.white.cgColor
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapButton))
        buttonGetStarted.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapButton() {
//        navigateToScreen(withIdentifier: AuthenticationViewController.identifier)
        navigateToAuthScreen()
    }

}

//
//  AddNewCardViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 21/02/2022.
//

import UIKit

class AddNewCardViewController: UIViewController {
    
    @IBOutlet weak var buttonGoBack: UIButton!
    @IBOutlet weak var buttonConfirm: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGestureRecognizers()
    }

    private func setupGestureRecognizers() {
        let buttonGoBackTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGoBack))
        buttonGoBack.addGestureRecognizer(buttonGoBackTapGestureRecognizer)
        
        let buttonConfirmTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapConfirm))
        buttonConfirm.addGestureRecognizer(buttonConfirmTapGestureRecognizer)
    }
    
    @objc func didTapGoBack() {
        navigateToScreen(withIdentifier: PaymentViewController.identifier)
    }
    
    @objc func didTapConfirm() {
        navigateToScreen(withIdentifier: PaymentViewController.identifier)
    }
}

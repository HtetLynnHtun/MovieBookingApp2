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
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardHolderTextField: UITextField!
    @IBOutlet weak var expirationTextField: UITextField!
    @IBOutlet weak var cvcTextField: UITextField!
    
    private var paymentMethodModel: PaymentMethodModel = PaymentMethodModelImpl.shared
    
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
        do {
            try validateUserInputs()
            
            let card = CardVO()
            card.cardNumber = cardNumberTextField.text!
            card.cardHolder = cardHolderTextField.text!
            card.expirationDate = expirationTextField.text!
            card.cvc = Int(cvcTextField.text!)!
            
            paymentMethodModel.createCard(card: card) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    self.navigateToScreen(withIdentifier: PaymentViewController.identifier)
                case .failure(let errorMessage):
                    self.showAlert(message: errorMessage)
                }
            }
        } catch {
            showAlert(message: error.localizedDescription)
        }
    }
    
    private func validateUserInputs() throws {
        if (cardNumberTextField.text == nil || cardNumberTextField.text!.count != 16) {
            throw "A valid credit card number must be 16 digits"
        }
        if (cardHolderTextField.text == nil || cardHolderTextField.text!.isEmpty) {
            throw "Please enter card holder name"
        }
        if (expirationTextField.text == nil || expirationTextField.text!.isEmpty) {
            throw "Please enter an expiration date"
        }
        if (cvcTextField.text == nil || cvcTextField.text!.count != 3) {
            throw "A valid cvc number must be 3 digits"
        }
        print("wtbug: validate success")
    }
}

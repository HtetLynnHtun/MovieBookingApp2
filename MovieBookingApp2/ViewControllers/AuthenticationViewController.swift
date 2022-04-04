//
//  AuthenticationViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var stackViewLogin: UIStackView!
    @IBOutlet weak var stackViewSignIn: UIStackView!
    @IBOutlet weak var labelLogin: UILabel!
    @IBOutlet weak var loginIndicator: UIView!
    @IBOutlet weak var labelSignIn: UILabel!
    @IBOutlet weak var signInIndicator: UIView!
    @IBOutlet weak var stackViewNameInput: UIStackView!
    @IBOutlet weak var stackViewPhoneInput: UIStackView!
    @IBOutlet weak var viewFacebookSignIn: UIView!
    @IBOutlet weak var viewGoogleSignIn: UIView!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var isLogin = true {
        didSet {
            if (isLogin) {
                setupLoginMode()
            } else {
                setupSignInMode()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTapGestureRecognizers()
        setupLoginMode()
        setupSignInButtons()
    }
    
    func setupTapGestureRecognizers() {
        let loginTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLogin))
        let signInTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSignIn))
        let confirmButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapConfirmButton))
        
        stackViewLogin.isUserInteractionEnabled = true
        stackViewSignIn.isUserInteractionEnabled = true
        
        stackViewLogin.addGestureRecognizer(loginTapGestureRecognizer)
        stackViewSignIn.addGestureRecognizer(signInTapGestureRecognizer)
        buttonConfirm.addGestureRecognizer(confirmButtonTapGestureRecognizer)
    }
    
    @objc func didTapLogin() {
        isLogin = true
    }
    
    @objc func didTapSignIn() {
        isLogin = false
    }
    
    @objc func didTapConfirmButton() {
        // TODO: Do validations
        
        let credentials = UserCredentialsVO(
            email: emailTextField.text!,
            password: passwordTextField.text!,
            name: nameTextField.text ?? "",
            phone: phoneTextField.text ?? "",
            googleAccessToken: "",
            facebookAccessToken: ""
        )
        if (isLogin) {
            loginInWithEmail(credentials: credentials)
        } else {
            signInWithEmail(credentials: credentials)
        }
        //        navigateToScreen(withIdentifier: HomeViewController.identifier)
    }
    
    private func setupLoginMode() {
        labelLogin.textColor = UIColor(named: "primary_color")
        loginIndicator?.backgroundColor = UIColor(named: "primary_color")
        
        labelSignIn.textColor = .black
        signInIndicator.backgroundColor = .white
        
        stackViewNameInput.isHidden = true
        stackViewPhoneInput.isHidden = true
    }
    
    private func setupSignInMode() {
        labelSignIn.textColor = UIColor(named: "primary_color")
        signInIndicator.backgroundColor = UIColor(named: "primary_color")
        
        labelLogin.textColor = .black
        loginIndicator.backgroundColor = .white
        
        stackViewNameInput.isHidden = false
        stackViewPhoneInput.isHidden = false
    }
    
    private func setupSignInButtons() {
        viewFacebookSignIn.layer.borderWidth = 0.5
        viewFacebookSignIn.layer.cornerRadius = 8
        viewFacebookSignIn.layer.borderColor = UIColor(named: "movie_seat_taken_color")?.cgColor
        
        viewGoogleSignIn.layer.borderWidth = 0.5
        viewGoogleSignIn.layer.cornerRadius = 8
        viewGoogleSignIn.layer.borderColor = UIColor(named: "movie_seat_taken_color")?.cgColor
    }
    
    // MARK: Model Communications
    private func loginInWithEmail(credentials: UserCredentialsVO) {
        AlamofireAgent.shared.loginWithEmail(credentials: credentials) { [weak self] result in
            switch result {
            case .success(let profile):
                print(profile.name)
            case .failure(let errorMessage):
                self?.showAlert(message: errorMessage)
            }
        }
    }
    
    private func signInWithEmail(credentials: UserCredentialsVO) {
        AlamofireAgent.shared.signInWithEmail(credentials: credentials) { [weak self] result in
            switch result {
            case .success(let profile):
                print(profile.name)
            case .failure(let errorMessage):
                self?.showAlert(message: errorMessage)
            }
        }
    }
}

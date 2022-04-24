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
    @IBOutlet weak var facebookSignInView: UIView!
    @IBOutlet weak var googleSignInView: UIView!
    
    var isLogin = true {
        didSet {
            if (isLogin) {
                setupLoginMode()
            } else {
                setupSignInMode()
            }
        }
    }
    let authModel: AuthModel = AuthModelImpl.shared
    
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
        let googleSignInTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGoogleSignIn))
        
        stackViewLogin.isUserInteractionEnabled = true
        stackViewSignIn.isUserInteractionEnabled = true
        googleSignInView.isUserInteractionEnabled = true
        
        stackViewLogin.addGestureRecognizer(loginTapGestureRecognizer)
        stackViewSignIn.addGestureRecognizer(signInTapGestureRecognizer)
        buttonConfirm.addGestureRecognizer(confirmButtonTapGestureRecognizer)
        googleSignInView.addGestureRecognizer(googleSignInTapGestureRecognizer)
    }
    
    @objc func didTapLogin() {
        isLogin = true
    }
    
    @objc func didTapSignIn() {
        isLogin = false
    }
    
    @objc func didTapConfirmButton() {
        do {
            try validateUserInputs()
            let credentials = getCredentials()
            if (isLogin) {
                loginWithEmail(credentials: credentials)
            } else {
                signIn(credentials: credentials)
            }
        } catch {
            showAlert(message: error.localizedDescription)
        }
    }
    
    @objc func didTapGoogleSignIn() {
        GoogleAuth.shared.start(view: self) { [weak self] response in
            guard let self = self else { return }
            if(self.isLogin) {
                self.loginWithGoogle(token: response.id)
            } else {
                do {
                    try self.validateUserInputs()
                    var credentials = self.getCredentials()
                    credentials.googleAccessToken = response.id
                    self.signIn(credentials: credentials)
                } catch {
                    self.showAlert(message: error.localizedDescription)
                }
            }
        } failure: { error in
            print(error)
        }

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
    
    private func getCredentials() -> UserCredentialsVO {
        return UserCredentialsVO(
            email: emailTextField.text!,
            password: passwordTextField.text!,
            name: nameTextField.text ?? "",
            phone: phoneTextField.text ?? "",
            googleAccessToken: "",
            facebookAccessToken: ""
        )
    }
    
    private func validateUserInputs() throws {
        if (emailTextField.text == nil || !InputValidation.isValidEmail(emailTextField.text!)) {
            throw "Please enter a valid email address"
        }
        if (passwordTextField.text == nil || passwordTextField.text!.isEmpty) {
            throw "Please enter a password"
        }
        if (!isLogin) {
            if (nameTextField.text == nil || nameTextField.text!.isEmpty) {
                throw "Please enter a name"
            }
            if (phoneTextField.text == nil || phoneTextField.text!.isEmpty) {
                throw "Please enter a phone number"
            }
        }
    }
    
    // MARK: Model Communications
    private func loginWithEmail(credentials: UserCredentialsVO) {
        authModel.loginWithEmail(credentials: credentials) { [weak self] result in
            switch result {
            case .success(_):
                self?.navigateToHomeScreen()
            case .failure(let errorMessage):
                self?.showAlert(message: errorMessage)
            }
        }
    }
    
    private func signIn(credentials: UserCredentialsVO) {
        authModel.signIn(credentials: credentials) { [weak self] result in
            switch result {
            case .success(_):
                self?.navigateToHomeScreen()
            case .failure(let errorMessage):
                self?.showAlert(message: errorMessage)
            }
        }
    }
    
    private func loginWithGoogle(token: String) {
        authModel.loginWithGoogle(token: token) { [weak self] result in
            switch result {
            case .success(_):
                self?.navigateToHomeScreen()
            case .failure(let errorMessage):
                self?.showAlert(message: errorMessage)
            }
        }
    }
}

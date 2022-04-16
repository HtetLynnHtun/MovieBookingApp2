//
//  SideMenuViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 16/04/2022.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logoutImageView: UIImageView!
    
    private let authModel: AuthModel = AuthModelImpl.shared
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProfile()
        setupLogout()
        print("wtbug: Sidemenu view didload")
    }
    
    deinit {
        print("wtbug: Sidemenu deinit")
    }
    
    private func setupLogout() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLogout))
        logoutImageView.isUserInteractionEnabled = true
        logoutImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func didTapLogout() {
        authModel.logout { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(_):
                print("wtbug: logout success")
                let rootVC = self.view.window?.rootViewController as! UINavigationController
                let landingVC = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: LandingViewController.identifier)

                self.dismiss(animated: false)
                rootVC.setViewControllers([landingVC], animated: false)
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
    }
    
    private func bindData(_ data: ProfileVO) {
        let avatarPath = AppConstants.baseAvatarUrl.appending(data.profileImage)
        avatarImageView.sd_setImage(with: URL(string: avatarPath))
        nameLabel.text = data.name
        emailLabel.text = data.email
    }

    private func getProfile() {
        authModel.getProfile { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.bindData(data)
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
    }
}

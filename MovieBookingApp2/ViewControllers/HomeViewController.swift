//
//  ViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 16/02/2022.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionViewNowShowing: UICollectionView!
    @IBOutlet weak var collectionViewComingSoon: UICollectionView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    private let authModel: AuthModel = AuthModelImpl.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupDataSourceAndDelegates()
        getProfile()
    }

    func registerCells() {
        collectionViewNowShowing.registerCell(MovieCollectionViewCell.identifier)
        collectionViewComingSoon.registerCell(MovieCollectionViewCell.identifier)
    }
    
    func setupDataSourceAndDelegates() {
        collectionViewNowShowing.dataSource = self
        collectionViewNowShowing.delegate = self
        
        collectionViewComingSoon.dataSource = self
        collectionViewComingSoon.delegate = self
    }
    
    private func setupAvatarSection() {
        
    }
    
    func onTapMovie() {
        navigateToScreen(withIdentifier: MovieDetailViewController.identifier)
    }
    
    func bindData(_ data: ProfileVO) {
        let avatarPath = AppConstants.baseImageUrl.appending(data.profileImage)
        avatarImageView.sd_setImage(with: URL(string: avatarPath))
        userNameLabel.text = data.name
    }
    
    // MARK: Model Communications
    func getProfile() {
        authModel.getProfile { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let profile):
                self.bindData(profile)
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionViewNowShowing.dequeCell(MovieCollectionViewCell.identifier, indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onTapMovie()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2.5
        let height = CGFloat(280)
        
        return CGSize(width: width, height: height)
    }
}

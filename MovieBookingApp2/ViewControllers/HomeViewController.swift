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
    private var nowShowingMovies = [MovieVO]()
    private var commingSoonMovies = [MovieVO]()
    private var courier = CourierVO()
    
    private let authModel: AuthModel = AuthModelImpl.shared
    private let movieModel: MovieModel = MovieModelImpl.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupDataSourceAndDelegates()
        getProfile()
        getNowShowingMovies()
        getCommingSoonMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
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
    
    func onTapMovie(id: Int) {
        courier.movieId = id
        navigateToMovieDetails(courier)
    }
    
    func bindData(_ data: ProfileVO) {
        let avatarPath = AppConstants.baseAvatarUrl.appending(data.profileImage)
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
    
    func getNowShowingMovies() {
        movieModel.getNowShowingMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.nowShowingMovies = data
                self.collectionViewNowShowing.reloadData()
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
    }
    
    func getCommingSoonMovies() {
        movieModel.getCommingSoonMovies { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.commingSoonMovies = data
                self.collectionViewComingSoon.reloadData()
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewNowShowing) {
            return nowShowingMovies.count
        } else {
            return commingSoonMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewNowShowing.dequeCell(MovieCollectionViewCell.identifier, indexPath) as MovieCollectionViewCell
        if (collectionView == collectionViewNowShowing) {
            cell.data = nowShowingMovies[indexPath.row]
        } else {
            cell.data = commingSoonMovies[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var contentId = 0
        if (collectionView == collectionViewNowShowing) {
            contentId = nowShowingMovies[indexPath.row].id
        } else {
            contentId = commingSoonMovies[indexPath.row].id
        }
        onTapMovie(id: contentId)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2.5
        let height = CGFloat(280)
        
        return CGSize(width: width, height: height)
    }
}

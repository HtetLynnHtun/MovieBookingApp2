//
//  MovieDetailViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 21/02/2022.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var viewCornerOverlay: UIView!
    @IBOutlet weak var collectionViewGenres: UICollectionView!
    @IBOutlet weak var collectionViewCasts: UICollectionView!
    @IBOutlet weak var buttonGetTicket: UIButton!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var ratingStar: RatingControl!
    
    var genres = [String]()
    var casts = [CastVO]()
    var courier: CourierVO!
    
    private let movieModel: MovieModel = MovieModelImpl.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white

        viewCornerOverlay.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewCornerOverlay.layer.cornerRadius = 32
        
        registerCells()
        setupDataSourcesAndDelegates()
        setupGestureRecognizers()
        getMovieDetails()
    }
    
    private func registerCells() {
        collectionViewGenres.registerCell(GenreCollectionViewCell.identifier)
        collectionViewCasts.registerCell(CastCollectionViewCell.identifier)
    }
    
    private func setupDataSourcesAndDelegates() {
        collectionViewGenres.dataSource = self
        collectionViewGenres.delegate = self
        
        collectionViewCasts.dataSource = self
        collectionViewCasts.delegate = self
    }
    
    private func setupGestureRecognizers() {
        let buttonGetTicketTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGetTicket))
        buttonGetTicket.addGestureRecognizer(buttonGetTicketTapGestureRecognizer)
    }
    
    @objc func didTapGetTicket() {
        navigateToMovieTime(courier)
    }
    
    private func bindData(_ data: MovieVO) {
        let posterPath = AppConstants.basePosterUrl.appending(data.posterPath)
        posterImageView.sd_setImage(with: URL(string: posterPath))
        titleLabel.text = data.originalTitle
        let runtime = data.runtime ?? 0
        let hour = runtime / 60
        let minutes = runtime % 60
        runtimeLabel.text = "\(hour)hr \(minutes)m"
        ratingStar.rating = Int((data.rating ?? 0.0) * 0.5)
        imdbLabel.text = "\(data.rating ?? 0.0)"
        summaryLabel.text = data.overview ?? ""
        
        genres = Array(data.genres)
        collectionViewGenres.reloadData()
        
        casts = Array(data.casts)
        collectionViewCasts.reloadData()
    }

    private func getMovieDetails() {
        movieModel.getMovieDetails(id: courier.movieId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.courier.movieName = data.originalTitle
                self.courier.runtime = "\(data.runtime ?? 0)"
                self.courier.posterPath = data.posterPath
                self.bindData(data)
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
    }
}

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewCasts) {
            return casts.count
        } else {
            return genres.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionViewCasts) {
            let cell = collectionView.dequeCell(CastCollectionViewCell.identifier, indexPath) as CastCollectionViewCell
            cell.layer.cornerRadius = 35.5
            cell.data = casts[indexPath.row]
            
            return cell
        } else {
            let cell = collectionView.dequeCell(GenreCollectionViewCell.identifier, indexPath) as GenreCollectionViewCell
            cell.layer.borderWidth = 0.2
            cell.layer.cornerRadius = 20
            cell.bindData(genreTitle: genres[indexPath.row])
            
            return cell
        }
    }
    
    
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == collectionViewCasts) {
            return CGSize(width: 75, height: 75)
        } else {
            return CGSize(width: 100, height: 40)
        }
    }
}

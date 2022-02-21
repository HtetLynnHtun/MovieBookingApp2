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
    
    var genres = ["Mystery", "Adventure"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewCornerOverlay.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewCornerOverlay.layer.cornerRadius = 32
        
        registerCells()
        setupDataSourcesAndDelegates()
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

}

extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewCasts) {
            return 10
        } else {
            return genres.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionViewCasts) {
            let cell = collectionView.dequeCell(CastCollectionViewCell.identifier, indexPath)
            cell.layer.cornerRadius = 35.5
            
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

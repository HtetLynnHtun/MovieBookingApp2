//
//  MovieSeatViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import UIKit

class MovieSeatViewController: UIViewController {

    @IBOutlet weak var collectionViewMovieSeats: UICollectionView!
    @IBOutlet weak var buttonGoBack: UIButton!
    @IBOutlet weak var buttonBuyTicket: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupDataSourcesAndDelegates()
        setupGestureRecognizers()
    }

    func registerCells() {
        collectionViewMovieSeats.registerCell(MovieSeatCollectionViewCell.identifier)
    }
    
    func setupDataSourcesAndDelegates() {
        collectionViewMovieSeats.dataSource = self
        collectionViewMovieSeats.delegate = self
    }
    
    private func setupGestureRecognizers() {
        let buttonGoBackTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGoBack))
        buttonGoBack.addGestureRecognizer(buttonGoBackTapGestureRecognizer)
        
        let buttonBuyTicketTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapBuyTicket))
        buttonBuyTicket.addGestureRecognizer(buttonBuyTicketTapGestureRecognizer)
    }
    
    @objc func didTapGoBack() {
        navigateToScreen(withIdentifier: MovieTimeViewController.identifier)
    }
    
    @objc func didTapBuyTicket() {
        navigateToScreen(withIdentifier: SnackViewController.identifier)
    }
}

extension MovieSeatViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyMovieSeats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(MovieSeatCollectionViewCell.identifier, indexPath) as MovieSeatCollectionViewCell
        cell.bindData(movieSeatVO: dummyMovieSeats[indexPath.row])
        
        return cell;
    }
    
    
}

extension MovieSeatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 10
        let height = CGFloat(40)
        
        return CGSize(width: width, height: height)
    }
}

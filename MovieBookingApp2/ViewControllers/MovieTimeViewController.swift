//
//  MovieTimeViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 16/02/2022.
//

import UIKit

class MovieTimeViewController: UIViewController {

    @IBOutlet weak var collectionViewDays: UICollectionView!
    @IBOutlet weak var collectionViewAvailableIn: UICollectionView!
    @IBOutlet weak var collectionViewGCGoldenCity: UICollectionView!
    @IBOutlet weak var collectionViewGCWestPoint: UICollectionView!
    @IBOutlet weak var viewContainerTimes: UIView!
    @IBOutlet weak var buttonGoBack: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    @IBOutlet weak var collectionViewHeightAvailableIn: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightGCGoldenCity: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightGCWestPoint: NSLayoutConstraint!
    
    private let cinemaModel: CinemaModel = CinemaModelImpl.shared
    var dates = [MyDate]()
    var cinemas = [CinemaVO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regsierCells()
        setupDataSourcesAndDelegates()
        setupHeightsForCollectionViews()
        setupGestureRecognizers()
        
        viewContainerTimes.clipsToBounds = true
        viewContainerTimes.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewContainerTimes.layer.cornerRadius = 16
        getDates()
        getCinemas()
    }
    
    func getDates() {
        dates = DateHelper.next10Days()
        collectionViewDays.reloadData()
    }
    
    func regsierCells() {
        collectionViewDays.registerCell(DayCollectionViewCell.identifier)
        collectionViewAvailableIn.registerCell(TimeCollectionViewCell.identifier)
        collectionViewGCGoldenCity.registerCell(TimeCollectionViewCell.identifier)
        collectionViewGCWestPoint.registerCell(TimeCollectionViewCell.identifier)
    }
    
    func setupDataSourcesAndDelegates() {
        collectionViewDays.dataSource = self
        collectionViewDays.delegate = self
        
        collectionViewAvailableIn.dataSource = self
        collectionViewAvailableIn.delegate = self
        
        collectionViewGCWestPoint.dataSource = self
        collectionViewGCWestPoint.delegate = self
        
        collectionViewGCGoldenCity.dataSource = self
        collectionViewGCGoldenCity.delegate = self
    }
    
    func setupHeightsForCollectionViews() {
        collectionViewHeightAvailableIn.constant = 56
        collectionViewHeightGCGoldenCity.constant = 56 * 2
        collectionViewHeightGCWestPoint.constant = 56 * 2
        
        self.view.layoutIfNeeded()
    }
    
    private func setupGestureRecognizers() {
        let buttonGoBackTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGoBack))
        buttonGoBack.addGestureRecognizer(buttonGoBackTapGestureRecognizer)
        
        let buttonNextTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapNext))
        buttonNext.addGestureRecognizer(buttonNextTapGestureRecognizer)
    }
    
    @objc func didTapGoBack() {
        navigateToScreen(withIdentifier: MovieDetailViewController.identifier)
    }
    
    @objc func didTapNext() {
        navigateToScreen(withIdentifier: MovieSeatViewController.identifier)
    }

    private func getCinemas() {
        cinemaModel.getCinemas { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.cinemas = data
                self.collectionViewAvailableIn.reloadData()
                
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
    }
}

extension MovieTimeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewDays) {
            return dates.count
        } else if (collectionView == collectionViewAvailableIn) {
            return cinemas.count
        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionViewDays) {
            let cell = collectionViewDays.dequeCell(DayCollectionViewCell.identifier, indexPath) as DayCollectionViewCell
            cell.date = dates[indexPath.row]
            return cell
        } else {
            let cell = collectionViewAvailableIn.dequeCell(TimeCollectionViewCell.identifier, indexPath) as TimeCollectionViewCell
            cell.data = cinemas[indexPath.row]
            return cell
        }
    }
    
}

extension MovieTimeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == collectionViewDays) {
            return CGSize(width: 60, height: 80)
        } else {
            let width = collectionView.bounds.width / 3
            let height = CGFloat(48)
            return CGSize(width: width, height: height)
        }
    }
}

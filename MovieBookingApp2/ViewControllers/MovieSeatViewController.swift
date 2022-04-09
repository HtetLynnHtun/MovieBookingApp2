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
    @IBOutlet weak var collectionViewSeatsHeight: NSLayoutConstraint!
    
    private var cinemaModel: CinemaModel = CinemaModelImpl.shared
    private var seats = [SeatVO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupDataSourcesAndDelegates()
        setupGestureRecognizers()
        getSeatPlan()
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
    
    private func setupHeightsForCollectionViews() {
        collectionViewSeatsHeight.constant = CGFloat(30 * (seats.count / 14))
        view.layoutIfNeeded()
    }
    
    @objc func didTapGoBack() {
        navigateToScreen(withIdentifier: MovieTimeViewController.identifier)
    }
    
    @objc func didTapBuyTicket() {
        let selectedSeats = seats.filter { $0.isSelected }
        print("wtbug: selected seats")
        selectedSeats.forEach { seat in
            print("wtbug: \(seat.seatName)")
        }
//        navigateToScreen(withIdentifier: SnackViewController.identifier)
    }
    
    private func toggleSelected(seatName: String) {
        if let seat = seats.first(where: { $0.seatName == seatName}) {
            print("wtbug: seat \(seatName) is tapped")
            seat.isSelected = !seat.isSelected
            collectionViewMovieSeats.reloadData()
            print("wtbug: =====================")
            seats.forEach { seat in
                print("wtbug: \(seat.seatName) -> \(seat.type) || \(seat.isSelected)")
            }
        }
    }
    
    // MARK: Model Communications
    private func getSeatPlan() {
        // TODO: Replace harcoded value
        let slotId = 1
        let date = "2021-6-29"
        cinemaModel.getSeatPlan(of: slotId, for: date) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let seatPlanVO):
                self.seats = Array(seatPlanVO.seats)
                self.setupHeightsForCollectionViews()
                self.collectionViewMovieSeats.reloadData()
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
    }
}

extension MovieSeatViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(MovieSeatCollectionViewCell.identifier, indexPath) as MovieSeatCollectionViewCell
        cell.data = seats[indexPath.row]
        cell.onTap = toggleSelected
        return cell;
    }
    
    
}

extension MovieSeatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 14
        let height = CGFloat(30)
        
        return CGSize(width: width, height: height)
    }
}

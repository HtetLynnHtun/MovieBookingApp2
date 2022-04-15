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
    @IBOutlet weak var ticketCountLabel: UILabel!
    @IBOutlet weak var selectedSeatsLabel: UILabel!
    
    private var cinemaModel: CinemaModel = CinemaModelImpl.shared
    var courier: CourierVO!
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
        collectionViewMovieSeats.allowsMultipleSelection = true
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
        navigateToScreen(withIdentifier: SnackViewController.identifier)
    }
    
    private func toggleSelected(id: UUID) {
        if let seat = seats.first(where: { $0.id == id}) {
            seat.isSelected = !seat.isSelected
            
            let selectedSeats = seats.filter { $0.isSelected }
            updateTicketCountLabel(selectedSeats)
            updateSelectedSeatsLabel(selectedSeats)
            updateBuyButtonTitle(selectedSeats)
        }
    }
    
    private func updateTicketCountLabel(_ selectedSeats: [SeatVO]) {
        ticketCountLabel.text = String(selectedSeats.count)
    }
    
    private func updateSelectedSeatsLabel(_ selectedSeats: [SeatVO]) {
        selectedSeatsLabel.text = selectedSeats.map { $0.seatName }.joined(separator: ",")
    }
    
    private func updateBuyButtonTitle(_ selectedSeats: [SeatVO]) {
        let totalTicketPrice = selectedSeats.reduce(0.0) { $0 + $1.price}
        let title = "Buy Ticket for $\(totalTicketPrice)"
        buttonBuyTicket.setTitle(title, for: .normal)
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
        let seat = seats[indexPath.row]
        cell.data = seat
        if (!seat.isAvailable()) {
            cell.isUserInteractionEnabled = false
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        toggleSelected(id: seats[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        toggleSelected(id: seats[indexPath.row].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return !(collectionView.cellForItem(at: indexPath)?.isSelected ?? false)
    }
}

extension MovieSeatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 14
        let height = CGFloat(30)
        
        return CGSize(width: width, height: height)
    }
}

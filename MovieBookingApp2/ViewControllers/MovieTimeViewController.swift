//
//  MovieTimeViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 16/02/2022.
//

import UIKit

class MovieTimeViewController: UIViewController {
    
    @IBOutlet weak var parentStackView: UIStackView!
    @IBOutlet weak var collectionViewDays: UICollectionView!
    @IBOutlet weak var collectionViewAvailableIn: UICollectionView!
    @IBOutlet weak var collectionViewTimeSlots: UICollectionView!
    @IBOutlet weak var viewContainerTimes: UIView!
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var collectionViewHeightTimeSlots: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewHeightAvailableIn: NSLayoutConstraint!
    
    private let cinemaModel: CinemaModel = CinemaModelImpl.shared
    var courier: CourierVO!
    var selectedDate = ""
    var selectedCinemaID = 0
    var selectedSlotID = 0
    var dates = [MyDate]()
    var cinemas = [CinemaVO]()
    var slotsData = [CinemaDayTimeSlotVO]()
//    var slotDataSources = [CinemaDataDSource]()
    
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
        getDayTimeSlots(for: dates.first!.complete)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor(named: "primary_color")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func getDates() {
        dates = DateHelper.next10Days()
        selectedDate = dates.first!.complete
        collectionViewDays.reloadData()
    }
    
    func regsierCells() {
        collectionViewDays.registerCell(DayCollectionViewCell.identifier)
        collectionViewAvailableIn.registerCell(TimeCollectionViewCell.identifier)
        collectionViewTimeSlots.registerCell(TimeCollectionViewCell.identifier)
    }
    
    func setupDataSourcesAndDelegates() {
        collectionViewDays.dataSource = self
        collectionViewDays.delegate = self
        
        collectionViewAvailableIn.dataSource = self
        collectionViewAvailableIn.delegate = self
        
        collectionViewTimeSlots.dataSource = self
        collectionViewTimeSlots.delegate = self
    }
    
    func setupHeightsForCollectionViews() {
        collectionViewHeightAvailableIn.constant = 56
        collectionViewHeightTimeSlots.constant = CGFloat((56 + 80) * slotsData.count)
        self.view.layoutIfNeeded()
    }
    
    private func setupGestureRecognizers() {
        let buttonNextTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapNext))
        buttonNext.addGestureRecognizer(buttonNextTapGestureRecognizer)
    }
    
    @objc func didTapNext() {
        courier.bookingDate = selectedDate
        courier.cinemaID = selectedCinemaID
        courier.cinemaDayTimeSlotID = selectedSlotID
        navigateToMovieSeat(courier)
    }
    
    private func didSelectDate(selected: MyDate) {
        selectedDate = selected.complete
        getDayTimeSlots(for: selected.complete)
    }
    
    private func didSelectCinema(id: Int) {
        selectedCinemaID = id
    }
    
    private func didSelectSlot(id: Int) {
        selectedSlotID = id
    }
    
    // MARK: Model communications
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
    
    private func getDayTimeSlots(for date: String) {
        cinemaModel.getDayTimeSlots(for: date) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.slotsData = data
                self.setupHeightsForCollectionViews()
                self.collectionViewTimeSlots.reloadData()
                
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
    }
}

extension MovieTimeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView == collectionViewTimeSlots) {
            return slotsData.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewDays) {
            return dates.count
        } else if (collectionView == collectionViewAvailableIn) {
            return cinemas.count
        } else {
            guard slotsData.count > 0 else {
                return 0
            }
            return slotsData[section].timeslots.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionViewDays) {
            let cell = collectionViewDays.dequeCell(DayCollectionViewCell.identifier, indexPath) as DayCollectionViewCell
            cell.date = dates[indexPath.row]
            
            if (indexPath.row == 0) {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
            }
            return cell
        } else if (collectionView == collectionViewAvailableIn) {
            let cell = collectionViewAvailableIn.dequeCell(TimeCollectionViewCell.identifier, indexPath) as TimeCollectionViewCell
            cell.data = cinemas[indexPath.row].name
            return cell
        } else {
            let cell = collectionViewTimeSlots.dequeCell(TimeCollectionViewCell.identifier, indexPath) as TimeCollectionViewCell
            cell.data = slotsData[indexPath.section].timeslots[indexPath.row].startTime
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: String(describing: TimeSlotHeaderView.self),
                for: indexPath
            ) as! TimeSlotHeaderView
            headerView.cinemaNameLabel.text = slotsData[indexPath.section].cinemaName
            
            return headerView
        default:
            assert(false, "Invalid element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == collectionViewDays) {
            didSelectDate(selected: dates[indexPath.row])
        } else if (collectionView == collectionViewAvailableIn) {
            didSelectCinema(id: cinemas[indexPath.row].id)
        } else {
            didSelectSlot(id: slotsData[indexPath.section].timeslots[indexPath.row].id)
        }
    }
    
}

extension MovieTimeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == collectionViewDays) {
            return CGSize(width: 40, height: 80)
        } else {
            let width = collectionView.bounds.width / 3
            let height = CGFloat(48)
            return CGSize(width: width, height: height)
        }
    }
}

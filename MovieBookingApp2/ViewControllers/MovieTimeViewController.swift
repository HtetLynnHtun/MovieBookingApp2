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
    @IBOutlet weak var viewContainerTimes: UIView!
    @IBOutlet weak var buttonGoBack: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    @IBOutlet weak var collectionViewHeightAvailableIn: NSLayoutConstraint!
    
    private let cinemaModel: CinemaModel = CinemaModelImpl.shared
    var dates = [MyDate]()
    var cinemas = [CinemaVO]()
    var dayTimeSlots = [CinemaDayTimeSlotVO]()
    var slotDataSources = [CinemaDataDSource]()
    
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
        getDayTimeSlots()
    }
    
    func getDates() {
        dates = DateHelper.next10Days()
        collectionViewDays.reloadData()
    }
    
    func regsierCells() {
        collectionViewDays.registerCell(DayCollectionViewCell.identifier)
        collectionViewAvailableIn.registerCell(TimeCollectionViewCell.identifier)
    }
    
    func setupDataSourcesAndDelegates() {
        collectionViewDays.dataSource = self
        collectionViewDays.delegate = self
        
        collectionViewAvailableIn.dataSource = self
        collectionViewAvailableIn.delegate = self
    }
    
    func setupHeightsForCollectionViews() {
        collectionViewHeightAvailableIn.constant = 56
        
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
    
    private func didSelectDate(selected: MyDate) {
        print("wtbug: user selected date: \(selected)")
    }
    
    private func setupTimeSlotCollectionViews(data: [CinemaDayTimeSlotVO]) {
        for (index, dataVO) in data.enumerated() {
            let stackView = UIStackView()
            stackView.axis = .vertical
            
            let dataSource = CinemaDataDSource()
            dataSource.data = Array(dataVO.timeslots)
            // need to retain dataSource object because [dataSource] is released
            self.slotDataSources.append(dataSource)
            
            stackView.addArrangedSubview(createTimeSlotTitle(dataVO.cinemaName))
            stackView.addArrangedSubview(createTimeSlotCollectionView(dataSource: self.slotDataSources[index]))
            self.parentStackView.removeArrangedSubview(buttonNext)
            self.parentStackView.addArrangedSubview(stackView)
            self.parentStackView.addArrangedSubview(buttonNext)
        }
    }
    
    private func createTimeSlotTitle(_ cinemaName: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.text = cinemaName
        return titleLabel
    }
    
    private func createTimeSlotCollectionView(dataSource: CinemaDataDSource) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        // Calculate row count
        var row = dataSource.data.count / 3
        if (dataSource.data.count % 3 != 0) {
            row += 1
        }
        collectionView.heightAnchor.constraint(equalToConstant: CGFloat(56 * row)).isActive = true

        
        return collectionView
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
    
    private func getDayTimeSlots() {
        // TODO: get user selected date
        let date = "2022-04-8"
        cinemaModel.getDayTimeSlots(for: date) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.setupTimeSlotCollectionViews(data: data)
                
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
        } else {
            return cinemas.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionViewDays) {
            let cell = collectionViewDays.dequeCell(DayCollectionViewCell.identifier, indexPath) as DayCollectionViewCell
            cell.date = dates[indexPath.row]
            return cell
        } else {
            let cell = collectionViewAvailableIn.dequeCell(TimeCollectionViewCell.identifier, indexPath) as TimeCollectionViewCell
            cell.data = cinemas[indexPath.row].name
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == collectionViewDays) {
            didSelectDate(selected: dates[indexPath.row])
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

class CinemaDataDSource: NSObject, UICollectionViewDataSource {
    
    var data = [TimeSlotVO]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.registerCell(TimeCollectionViewCell.identifier)
        let cell = collectionView.dequeCell(TimeCollectionViewCell.identifier, indexPath) as TimeCollectionViewCell
        cell.data = data[indexPath.row].startTime
        return cell
    }
    
}

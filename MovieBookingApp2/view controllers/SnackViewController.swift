//
//  SnackViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 19/02/2022.
//

import UIKit

class SnackViewController: UIViewController {

    @IBOutlet weak var buttonMStackView: UIStackView!
    @IBOutlet weak var buttonLStackView: UIStackView!
    @IBOutlet weak var button2StackView: UIStackView!
    @IBOutlet weak var snackCountMView: UIView!
    @IBOutlet weak var snackCountLView: UIView!
    @IBOutlet weak var snackCount2View: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBorderColors()
    }

    private func setupBorderColors() {
        buttonMStackView.layer.borderColor = UIColor.init(named: "movie_seat_taken_color")?.cgColor
        buttonLStackView.layer.borderColor = UIColor.init(named: "movie_seat_taken_color")?.cgColor
        button2StackView.layer.borderColor = UIColor.init(named: "movie_seat_taken_color")?.cgColor
        
        snackCountMView.layer.borderColor = UIColor.init(named: "movie_seat_taken_color")?.cgColor
        snackCountLView.layer.borderColor = UIColor.init(named: "movie_seat_taken_color")?.cgColor
        snackCount2View.layer.borderColor = UIColor.init(named: "movie_seat_taken_color")?.cgColor
    }
}

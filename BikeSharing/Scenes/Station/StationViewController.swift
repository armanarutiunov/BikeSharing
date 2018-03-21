//
//  StationViewController.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit
import ModelLayer
import RxSwift
import RxCocoa

class StationViewController: ViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var freeSpaceLabel: UILabel!
    @IBOutlet weak var freeBikesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var parkBikeButton: UIButton!
    
    var presenter: StationPresenter<StationViewController>!
    private let bikes = PublishSubject<[Bike]>()
    private var bookSignal = PublishSubject<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.attachView(viewIO: self).disposed(by: disposeBag)
    }
}

extension StationViewController: StationViewIO {
    var backButtonPressed: Action {
        return backButton.rx.tap.asAction()
    }
    
    var bookBike: Driver<Int> {
        return bookSignal.asDriver(onErrorDriveWith: .never())
    }
    
    var parkBike: Action {
        return parkBikeButton.rx.tap.asAction()
    }
    
    func showBikes(_ bikes: [Bike]) {
        self.bikes.onNext(bikes)
    }
    
    func show(loading: Bool) {
        
    }
}

extension StationViewController {
    
    private func setupView() {
        setupBackButton()
        setupParkBikeButton()
        setupTableView()
    }
    
    private func setupBackButton() {
        backButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        backButton.contentMode = .center
        backButton.imageView?.contentMode = .center
        backButton.imageView?.tintColor = UIColor.white
    }
    
    private func setupParkBikeButton() {
        parkBikeButton.layer.cornerRadius = 6
        parkBikeButton.setBackgroundImage(UIColor.lightGray.toImage(), for: .disabled)
        parkBikeButton.setBackgroundImage(UIColor.cobiBlue.toImage(), for: .normal)
        parkBikeButton.setTitleColor(UIColor.gray, for: .disabled)
        parkBikeButton.setTitleColor(UIColor.white, for: .normal)
        parkBikeButton.backgroundColor = UIColor.clear
        parkBikeButton.isEnabled = false
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "BikeCell", bundle: Bundle(for: BikeCell.self))
        tableView.register(nib, forCellReuseIdentifier: "BikeCell")
        bikes
            .bind(to: tableView.rx.items(cellIdentifier: "BikeCell", cellType: BikeCell.self)) { [weak self] (row, element, cell) in
                guard let `self` = self else { return }
                cell.bike = element
                cell.bookBikeButton.rx.tap.asAction()
                    .drive(onNext: { [weak self] _ in
                        self?.bookSignal.onNext(row)
                    })
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
        
    }
    
}
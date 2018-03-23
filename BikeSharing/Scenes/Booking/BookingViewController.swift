//
//  BookingViewController.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 22/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit
import ModelLayer
import RxSwift

class BookingViewController: ViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var bikeIcon: UIImageView!
    @IBOutlet weak var bookingWillExpireLabel: UILabel!
    @IBOutlet weak var timeLeft: UILabel!
    @IBOutlet weak var pin: UILabel!
    @IBOutlet weak var startRideButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var presenter: BookingPresenter<BookingViewController>!
    
    private let alertOkSignal = PublishSubject<Void>()
    private let startRideOkSignal = PublishSubject<Void>()
    let timerFinishSignal = PublishSubject<Void>()
    private var timer = Timer()
    private var time: TimeInterval!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.attachView(viewIO: self).disposed(by: disposeBag)
    }
}

extension BookingViewController: BookingViewIO {
    var backButtonPressed: Action {
        return backButton.rx.tap.asAction()
    }
    
    var startRideButtonPressed: Action {
        return startRideButton.rx.tap.asAction()
    }
    
    var timerFinished: Action {
        return timerFinishSignal.asDriver(onErrorDriveWith: .never())
    }
    
    var alertOkPressed: Action {
        return alertOkSignal.asDriver(onErrorDriveWith: .never())
    }
    
    var startRideOkAlert: Action {
        return startRideOkSignal.asDriver(onErrorDriveWith: .never())
    }
    
    var cancelButtonPressed: Action {
        return cancelButton.rx.tap.asAction()
    }
    
    func showTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func configureBikeColor(_ color: UIColor) {
        bikeIcon.tintColor = color
    }
    
    func showTimeLeft(_ time: TimeInterval) {
        self.time = time
        runTimer()
    }
    
    func showPin(_ pin: String) {
        self.pin.text = pin
    }
    
    func showExpirationAlert() {
        showAlert(title: "Your booking is expired",
                  message: "Please book a new bike",
                  alertAction: { [weak self] _ in self?.alertOkSignal.onNext(())})
    }
    
    func showStartRideAlert() {
        timer.invalidate()
        timeLeft.isHidden = true
        bookingWillExpireLabel.text = "Ride has already started!"
        showAlert(title: "Congrats!",
                  message: "You started a new ride!",
                  alertAction: { [weak self] _ in self?.startRideOkSignal.onNext(())})
    }
    
    func show(loading: Bool) { }
}

extension BookingViewController {
    
    private func setupView() {
        backButton.imageView?.tintColor = UIColor.white
        startRideButton.layer.cornerRadius = 6
        cancelButton.layer.cornerRadius = 6
        timeLeft.isHidden = true
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if time < 1 {
            timer.invalidate()
            timerFinishSignal.onNext(())
            return
        }
        time = time - 1
        timeLeft.text = "\(time.string)"
        timeLeft.isHidden = false
    }
    
}

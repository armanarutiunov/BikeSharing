//
//  StatusView.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit
import ModelLayer
import RxSwift

class StatusView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var bookingLabel: UILabel!
    @IBOutlet weak var rideLabel: UILabel!
    @IBOutlet weak var lookButton: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    let timerFinishSignal = PublishSubject<Void>()
    
    var state: State! {
        didSet {
            guard let state = state else { return }
            switch state {
            case .closed:
                configureState(hidden: true, onRide: false)
            case .booked:
                configureState(hidden: false, onRide: false)
            case .onRide:
                configureState(hidden: false, onRide: true)
            }
        }
    }
    
    var time: TimeInterval! {
        didSet {
            guard let time = time else { return }
            timer.invalidate()
            state == .booked ?
                runTimer() :
                runStopwatch(time: time)
        }
    }
    
    var timer = Timer()
    var stopwatch = Timer()

    // MARK: - Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        state = .closed
    }
    
    // MARK: - Timer
    
    private func configureState(hidden: Bool, onRide: Bool) {
        bookingLabel.isHidden = onRide
        lookButton.isHidden = onRide
        rideLabel.isHidden = !onRide
        isHidden = hidden
        heightConstraint.constant = hidden ? 0 : 44
        layoutIfNeeded()
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
        bookingLabel.text = "Booking will expire in \(time.string)"
    }
    
    // MARK: - Stopwatch
    
    private func runStopwatch(time: TimeInterval) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateStopwatch)), userInfo: nil, repeats: true)
    }
    
    @objc private func updateStopwatch() {
        time = time + 1
        rideLabel.text = "You are on a ride for \(time.string)"
    }

}

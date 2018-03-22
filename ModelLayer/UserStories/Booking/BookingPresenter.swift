//
//  BookingPresenter.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 22/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift

public class BookingPresenter<V: BookingViewIO>: Presenter<V> {
    
    private let interactor: BookingInteractor
    private let navigator: BookingNavigator
    
    public init(interactor: BookingInteractor, navigator: BookingNavigator) {
        self.interactor = interactor
        self.navigator = navigator
    }
    
    override func setup() {
        
    }
    
    // create booking with: bike, time until
    // start a ride: bike, time started
    // end ride: bike, station
    
    override func viewAttached() -> Disposable {
        guard let viewIO = viewIO else { return Disposables.create() }
        
        return disposable(
            viewIO.backButtonPressed.drive(onNext: { [weak self] in
                self?.navigator.back()
            }),
            viewIO.startRideButtonPressed.drive(onNext: { _ in
                /// start a ride
            }),
            viewIO.timerFinished.drive(onNext: { _ in
                viewIO.showExpirationAlert()
            }),
            viewIO.alertOkPressed.drive(onNext: { [weak self] in
                /// cancel booking
                self?.navigator.back()
            })
        )
    }
}

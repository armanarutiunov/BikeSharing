//
//  BookingPresenter.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 22/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift
import RxCocoa

public class BookingPresenter<V: BookingViewIO>: Presenter<V> {
    
    private let interactor: BookingInteractor
    private let navigator: BookingNavigator
    private let bike = BehaviorRelay<Bike>(value: Bike(id: 1, name: "", frameColor: .blue, pin: 1111))
    
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
            interactor.getBookedBike()
                .subscribe(onNext: { [weak self] bike in
                    if let bike = bike {
                        self?.setupView(bike)
                        self?.bike.accept(bike)
                    }
                }
            ),
            viewIO.backButtonPressed.drive(onNext: { [weak self] in
                self?.navigator.back()
            }),
            viewIO.startRideButtonPressed.drive(onNext: { [weak self] _ in
                self?.startRide()
            }),
            viewIO.timerFinished.drive(onNext: { _ in
                viewIO.showExpirationAlert()
            }),
            viewIO.alertOkPressed.drive(onNext: { [weak self] in
                self?.endRide()
            }),
            viewIO.startRideOkAlert.drive(onNext: { [weak self] in
                self?.navigator.backToMap()
            })
        )
    }
    
    private func setupView(_ bike: Bike) {
        let color: UIColor
        switch bike.frameColor {
        case .blue:
            color = UIColor.cobiBlue
        case .green:
            color = UIColor.greenBike
        case .red:
            color = UIColor.redBike
        }
        viewIO?.configureBikeColor(color)
        viewIO?.showTimeLeft(bike.bookingExpiration ?? 600)
        viewIO?.showPin("\(bike.pin)")
    }
    
    private func startRide() {
        interactor.startRide(bike.value)
            .subscribe(onNext: { [weak self] in
                self?.viewIO?.showStartRideAlert()
            })
            .disposed(by: disposeBag)
    }
    
    private func endRide() {
        interactor.endRide()
            .subscribe(onNext: { [weak self] in
                self?.navigator.back()
            })
            .disposed(by: disposeBag)
    }
}

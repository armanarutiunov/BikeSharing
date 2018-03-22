//
//  StationPresenter.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift
import RxCocoa

public class StationPresenter<V: StationViewIO>: Presenter<V> {
    
    private let interactor: StationInteractor
    private let navigator: StationNavigator
    private let station: Station
    private let bikes = BehaviorRelay<[Bike]>(value: [Bike]())
    private let bookedBike = BehaviorRelay<Bike?>(value: nil)
    
    public init(interactor: StationInteractor, navigator: StationNavigator, station: Station) {
        self.interactor = interactor
        self.navigator = navigator
        self.station = station
    }
    
    override func setup() {
        bikes.accept(station.bikes)
        viewIO?.showStationId("\(station.id)")
        self.viewIO?.updateFreeBikesCounter(self.bikes.value.count)
        self.viewIO?.updateFreeSpaceCounter(self.station.capacity - self.bikes.value.count)
    }
    
    override func viewAttached() -> Disposable {
        guard let viewIO = viewIO else { return Disposables.create() }
        
        let ridingBike = interactor.getRidingBike().asDriver(onErrorDriveWith: .never())
        let bookedBike = interactor.getBookedBike().asDriver(onErrorDriveWith: .never())
        
        return disposable(
            ridingBike.drive(onNext: { bike in
                viewIO.toggleParkButton(bike != nil)
            }),
            bookedBike.drive(onNext: { [weak self] bike in
                guard let `self` = self else { return }
                if let bike = bike {
                    self.bookedBike.accept(bike)
                    self.bikes.value.forEach {
                        if $0.id == bike.id {
                            viewIO.markBikeAsBooked($0.id)
                        }
                    }
                }
                viewIO.showBikes(self.bikes.value)
            }),
            viewIO.backButtonPressed.drive(onNext: { [weak self] in
                self?.navigator.back()
            }),
            viewIO.bookBike.drive(onNext: { [weak self] index in
                guard let `self` = self else { return }
                let bike = self.bikes.value[index]
                if self.bookedBike.value == nil {
                    self.bookBike(bike)
                } else if bike.id == self.bookedBike.value?.id {
                    self.navigator.toBooking()
                } else {
                    viewIO.showAlreadyBookedAlert()
                }
            }),
            viewIO.parkBike.drive(onNext: { [weak self] in
                self?.parkBike()
            })
        )
    }
    
    private func bookBike(_ bike: Bike) {
        interactor.bookBike(bike)
            .subscribe(
                onNext: { [weak self] in
                    guard let `self` = self else { return }
                    let newBikesAmount = self.bikes.value.count - 1
                    self.viewIO?.updateFreeBikesCounter(newBikesAmount)
                    self.viewIO?.updateFreeSpaceCounter(self.station.capacity - newBikesAmount)
                    self.navigator.toBooking()
            })
            .disposed(by: disposeBag)
    }
    
    private func parkBike() {
        interactor.parkBike()
            .subscribe(
                onNext: { [weak self] in
                    guard let `self` = self else { return }
                    let newBikesAmount = self.bikes.value.count + 1
                    self.viewIO?.updateFreeBikesCounter(newBikesAmount)
                    self.viewIO?.updateFreeSpaceCounter(self.station.capacity - newBikesAmount)
                    self.viewIO?.toggleParkButton(false)
                    self.viewIO?.showAlertParkedBike()
            })
            .disposed(by: disposeBag)
    }
    
}

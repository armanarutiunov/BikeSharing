//
//  StationPresenter.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift
import RxCocoa

/*
 
 /// Баги
 5. когда букаешь байк и переходишь на другую станцию, показывает тот же байк забукенным
 6. после того, как начал поездку, если вернуться в станцию он все равно показывает 15 свободных и 15 занятых мест
 
 
 /// Импрувы
 4. на экране карты добавить работу с зеленой вьюшкой
 
 */

public class StationPresenter<V: StationViewIO>: Presenter<V> {
    
    private let interactor: StationInteractor
    private let navigator: StationNavigator
    private let station: Station
    private let bikes = BehaviorRelay<[Bike]>(value: [Bike]())
    private let bookedBike = BehaviorRelay<Bike?>(value: nil)
    private let ridingBike = BehaviorRelay<Bike?>(value: nil)
    private let markedBike = BehaviorRelay<Bike?>(value: nil)
    
    public init(interactor: StationInteractor, navigator: StationNavigator, station: Station) {
        self.interactor = interactor
        self.navigator = navigator
        self.station = station
    }
    
    override func setup() {
        bikes.accept(station.bikes)
        viewIO?.showStationId("\(station.id)")
        viewIO?.updateFreeBikesCounter(bikes.value.count)
        viewIO?.updateFreeSpaceCounter(station.capacity - bikes.value.count)
    }
    
    override func viewAttached() -> Disposable {
        guard let viewIO = viewIO else { return Disposables.create() }
        
        let myBikes = Observable.combineLatest(interactor.getBookedBike().asObservable(),
                                               interactor.getRidingBike().asObservable()) { ($0, $1) }
            .asDriver(onErrorDriveWith: .never())
        
        return disposable(
            myBikes.drive(onNext: { [weak self] booked, riding in
                self?.handleMyBikes(booked: booked, riding: riding)
            }),
            viewIO.backButtonPressed.drive(onNext: { [weak self] in
                self?.navigator.back()
            }),
            viewIO.bookBike.drive(onNext: { [weak self] index in
                self?.bookBikePressed(at: index)
            }),
            viewIO.parkBike.drive(onNext: { [weak self] in
                self?.parkBike()
            })
        )
    }
    
    private func handleMyBikes(booked: Bike?, riding: Bike?) {
        viewIO?.toggleParkButton(riding != nil)
        if let riding = riding { ridingBike.accept(riding) }
        if let bike = booked {
            bookedBike.accept(bike)
            bikes.value.forEach {
                if $0.id == bike.id {
                    markedBike.accept(bike)
                    viewIO?.markBikeAsBooked($0.id)
                }
            }
        } else if markedBike.value != nil {
            viewIO?.unmarkBikeAsBooked()
            markedBike.accept(nil)
        }
        viewIO?.showBikes(bikes.value)
    }
    
    private func bookBikePressed(at index: Int) {
        let bike = bikes.value[index]
        if bookedBike.value == nil && ridingBike.value == nil {
            bookBike(bike)
        } else if self.ridingBike.value != nil {
            viewIO?.showRidingAlert()
        } else if bike.id == bookedBike.value?.id {
            navigator.toBooking()
            viewIO?.prepareToGoToBooking()
        } else {
            viewIO?.showAlreadyBookedAlert()
        }
    }
    
    private func bookBike(_ bike: Bike) {
        interactor.bookBike(bike)
            .subscribe(
                onNext: { [weak self] in
                    guard let `self` = self else { return }
                    self.updateSpaceCounters(bikesAmount: self.bikes.value.count - 1)
                    self.navigator.toBooking()
                    self.viewIO?.prepareToGoToBooking()
            })
            .disposed(by: disposeBag)
    }
    
    private func parkBike() {
        interactor.parkBike()
            .subscribe(
                onNext: { [weak self] in
                    guard let `self` = self else { return }
                    let bikes = self.bikes.value + [self.ridingBike.value!]
                    self.viewIO?.showBikes(bikes)
                    self.updateSpaceCounters(bikesAmount: bikes.count)
                    self.ridingBike.accept(nil)
                    self.viewIO?.toggleParkButton(false)
                    self.viewIO?.showAlertParkedBike()
            })
            .disposed(by: disposeBag)
    }
    
    private func updateSpaceCounters(bikesAmount: Int) {
        self.viewIO?.updateFreeBikesCounter(bikesAmount)
        self.viewIO?.updateFreeSpaceCounter(self.station.capacity - bikesAmount)
    }
    
}

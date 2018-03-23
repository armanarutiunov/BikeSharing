//
//  MockStationViewIO.swift
//  ModelLayerTests
//
//  Created by Arman Arutyunov on 23/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import ModelLayer
import RxSwift
import RxCocoa

class MockStationViewIO: StationViewIO {
    var _show: (Bool) -> Void = { _ in }
    func show(loading: Bool) { _show(loading) }
    
    
    var _backButtonPressed = PublishSubject<Void>()
    var backButtonPressed: Action { return _backButtonPressed.asDriver(onErrorDriveWith: .never()) }
    
    var _bookBike = PublishSubject<Int>()
    var bookBike: Driver<Int> { return _bookBike.asDriver(onErrorDriveWith: .never()) }
    
    var _parkBike = PublishSubject<Void>()
    var parkBike: Action { return _parkBike.asDriver(onErrorDriveWith: .never()) }
    
    var _showStationId: (String) -> Void = { _ in }
    func showStationId(_ id: String) { return _showStationId(id) }
    
    var _showBikes: ([Bike]) -> Void = { _ in }
    func showBikes(_ bikes: [Bike]) { return _showBikes(bikes) }
    
    var _updateFreeSpaceCounter: (Int) -> Void = { _ in }
    func updateFreeSpaceCounter(_ amount: Int) { return _updateFreeSpaceCounter(amount) }
    
    var _updateFreeBikesCounter: (Int) -> Void = { _ in }
    func updateFreeBikesCounter(_ amount: Int) { return _updateFreeBikesCounter(amount) }
    
    var _showAddress: (String) -> Void = { _ in }
    func showAddress(_ address: String) { return _showAddress(address) }
    
    var _toggleParkButton: (Bool) -> Void = { _ in }
    func toggleParkButton(_ enabled: Bool) { return _toggleParkButton(enabled) }
    
    var _showAlreadyBookedAlert: () -> Void = {  }
    func showAlreadyBookedAlert() { return _showAlreadyBookedAlert() }
    
    var _markBikeAsBooked: (Int) -> Void = {
        _ in }
    func markBikeAsBooked(_ id: Int) {
        return _markBikeAsBooked(id)
        
    }
    
    var _unmarkBikeAsBooked: () -> Void = {}
    func unmarkBikeAsBooked() { return _unmarkBikeAsBooked() }

    var _showAlertParkedBike: () -> Void = {}
    func showAlertParkedBike() { return _showAlertParkedBike() }
    
    var _showRidingAlert: () -> Void = {}
    func showRidingAlert() { return _showRidingAlert() }
    
    var _prepareToGoToBooking: () -> Void = {}
    func prepareToGoToBooking() { return _prepareToGoToBooking() }
    
}

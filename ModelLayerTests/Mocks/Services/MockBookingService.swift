//
//  MockBookingService.swift
//  ModelLayerTests
//
//  Created by Arman Arutyunov on 23/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import ModelLayer
import RxSwift

class MockBookingService: BookingService {
    
    var _bookBike = PublishSubject<Void>()
    func bookBike(_ bike: Bike) -> Observable<Void> { return _bookBike }
    
    var _getBookedBike = PublishSubject<Bike?>()
    func getBookedBike() -> Observable<Bike?> { return _getBookedBike }
    
    var _cancelBooking = PublishSubject<Void>()
    func cancelBooking() -> Observable<Void> { return _cancelBooking }
    
    var _startRide = PublishSubject<Void>()
    func startRide(_ bike: Bike) -> Observable<Void> { return _startRide }
    
    var _getRidingBike = PublishSubject<Bike?>()
    func getRidingBike() -> Observable<Bike?> { return _getRidingBike }
    
    var _endRide = PublishSubject<Void>()
    func endRide() -> Observable<Void> { return _endRide }
    
}

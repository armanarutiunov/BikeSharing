//
//  StationInteractor.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift

public class StationInteractor: Interactor {
    
    private let bookingService: BookingService
    
    public init(executors: Executors, bookingService: BookingService) {
        self.bookingService = bookingService
        super.init(executors: executors)
    }
    
    public func bookBike(_ bike: Bike) -> Observable<Void> {
        return applySchedulers(
            bookingService.bookBike(bike)
        )
    }
    
    public func getBookedBike() -> Observable<Bike?> {
        return applySchedulers(
            bookingService.getBookedBike()
        )
    }
    
    public func getRidingBike() -> Observable<Bike?> {
        return applySchedulers(
            bookingService.getRidingBike()
        )
    }
    
    public func parkBike() -> Observable<Void> {
        return applySchedulers(
            bookingService.endRide()
        )
    }
}

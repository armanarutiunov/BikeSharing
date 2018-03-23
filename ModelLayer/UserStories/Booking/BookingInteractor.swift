//
//  BookingInteractor.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 22/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift

public class BookingInteractor: Interactor {
    
    let bookingService: BookingService
    
    public init(executors: Executors, bookingService: BookingService) {
        self.bookingService = bookingService
        super.init(executors: executors)
    }
    
    public func getBookedBike() -> Observable<Bike?> {
        return applySchedulers(
            bookingService.getBookedBike()
        )
    }
    
    public func cancelBooking() -> Observable<Void> {
        return applySchedulers(
            bookingService.cancelBooking()
        )
    }
    
    public func startRide(_ bike: Bike) -> Observable<Void> {
        return applySchedulers(
            bookingService.startRide(bike)
        )
    }
}

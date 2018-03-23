//
//  MapInteractor.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift

public class MapInteractor: Interactor {
    
    private let stationService: StationService
    private let bookingService: BookingService
    
    public init(executors: Executors, stationService: StationService, bookingService: BookingService) {
        self.stationService = stationService
        self.bookingService = bookingService
        super.init(executors: executors)
    }
    
    public func getStations() -> Observable<[Station]> {
        return applySchedulers(
            stationService.getStations()
        )
    }
    
    public func getBookedBike() -> Observable<Bike?> {
        return applySchedulers(
            bookingService.getBookedBike()
        )
    }
    
    func cancelBooking() -> Observable<Void> {
        return applySchedulers(
            bookingService.cancelBooking()
        )
    }
    
    public func getRidingBike() -> Observable<Bike?> {
        return applySchedulers(
            bookingService.getRidingBike()
        )
    }
}

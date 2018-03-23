//
//  BookingService.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 22/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift

public protocol BookingService {
    func bookBike(_ bike: Bike) -> Observable<Void>
    func getBookedBike() -> Observable<Bike?>
    func cancelBooking() -> Observable<Void>
    func startRide(_ bike: Bike) -> Observable<Void>
    func getRidingBike() -> Observable<Bike?>
    func endRide() -> Observable<Void>
}

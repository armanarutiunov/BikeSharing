//
//  StubBookingService.swift
//  DataLayer
//
//  Created by Arman Arutyunov on 22/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift
import ModelLayer
import Gloss

public class StubBookingService: BookingService {
    
    let bookedBikeKey = "bookedBike"
    let ridingBikeKey = "ridingBike"
    
    public init() {}
    
    public func bookBike(_ bike: Bike) -> Observable<Void> {
        return Observable.just(0).map { [weak self] _ in
            guard let `self` = self else { return }
            var bike = bike
            bike.bookingExpiration = 600
            self.saveBike(bike, key: self.bookedBikeKey)
        }
    }
    
    public func getBookedBike() -> Observable<Bike?> {
        return Observable.just(0).map { [weak self] _ -> Bike? in
            guard let `self` = self else { return nil }
            return self.getSavedBike(with: self.bookedBikeKey)
        }
    }
    
    public func startRide(_ bike: Bike) -> Observable<Void> {
        return Observable.just(0).map { [weak self] _ in
            guard let `self` = self else { return }
            UserDefaults.standard.removeObject(forKey: self.ridingBikeKey)
            var bike = bike
            bike.rideStart = Date().timeIntervalSince1970
            self.saveBike(bike, key: "ridingBike")
        }
    }
    
    public func getRidingBike() -> Observable<Bike?> {
        return Observable.just(0).map { [weak self] _ -> Bike? in
            guard let `self` = self else { return nil }
            return self.getSavedBike(with: self.ridingBikeKey)
        }
    }
    
    public func endRide() -> Observable<Void> {
        return Observable.just(0).map{ [weak self] _ in
            guard let `self` = self else { return }
            UserDefaults.standard.removeObject(forKey: self.ridingBikeKey)
        }
    }
    
    // MARK: - Helper methods
    
    private func saveBike(_ bike: Bike, key: String) {
        let bikeJSON = bike.toJSON() ?? [:]
        UserDefaults.standard.setValue(bikeJSON, forKey: key)
    }
    
    private func getSavedBike(with key: String) -> Bike? {
        guard let bikeJSON = UserDefaults.standard.value(forKey: "bookedBike") as? JSON else { return nil }
        return Bike(json: bikeJSON)
    }
}

extension Bike: Gloss.JSONEncodable {
    public func toJSON() -> JSON? {
        return jsonify([
            "id" ~~> id,
            "name" ~~> name,
            "frameColor" ~~> frameColor,
            "pin" ~~> pin,
            "bookingExpiration" ~~> bookingExpiration,
            "rideStart" ~~> rideStart
            ])
    }
}

extension Bike: Gloss.JSONDecodable {
    public init?(json: JSON) {
        guard
            let id: Int = "id" <~~ json,
            let name: String = "name" <~~ json,
            let frameColor: String = "frameColor" <~~ json,
            let pin: Int = "pin" <~~ json
            else { return nil }
        self.bookingExpiration = nil
        if let bookingExpiration: TimeInterval? = "bookingExpiration" <~~ json {
            self.bookingExpiration = bookingExpiration
        }
        self.rideStart = nil
        if let rideStart: TimeInterval? = "rideStart" <~~ json {
            self.rideStart = rideStart
        }
        self.id = id
        self.name = name
        self.frameColor = FrameColor(rawValue: frameColor)!
        self.pin = pin
    }
}

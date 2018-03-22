//
//  StationViewIO.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxCocoa

public protocol StationViewIO: ViewIO {
    
    /// Back button pressed
    var backButtonPressed: Action { get }
    
    /// Bike is booked
    var bookBike: Driver<Int> { get }
    
    /// Park a bike
    var parkBike: Action { get }
    
    /// Show station id
    func showStationId(_ id: String)
    
    /// Show bikes
    func showBikes(_ bikes: [Bike])
    
    /// Update free space counter
    func updateFreeSpaceCounter(_ amount: Int)
    
    /// Update free bikes counter
    func updateFreeBikesCounter(_ amount: Int)
    
    /// Toggle park button
    func toggleParkButton(_ enabled: Bool)
    
    /// Show alert that user already booked another bike
    func showAlreadyBookedAlert()
    
    /// Mark already booked bike
    func markBikeAsBooked(_ id: Int)
    
    /// Show alert thar user parked his bike
    func showAlertParkedBike()
    
}

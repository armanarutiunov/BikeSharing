//
//  MapViewIO.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

public protocol MapViewIO: ViewIO {
    
    /// Booking timer finished
    var timerFinished: Action { get }
    
    /// Show stations on the map
    func showStations(_ stations: [Station])
    
    /// Update status view and pass time for timers
    func updateStatus(state: State, time: TimeInterval?)
    
    /// User ended ride
    func endedRide()
    
    /// Show Error
    func showError(_ error: ErrorWithRecovery)
}

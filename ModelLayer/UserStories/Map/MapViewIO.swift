//
//  MapViewIO.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxCocoa

public protocol MapViewIO: ViewIO {
    
    /// User tapped station
    var stationTapped: Driver<Station> { get }
    
    /// Show stations on the map
    func showStations(_ stations: [Station])
    
    /// Show Error
    func showError(_ error: ErrorWithRecovery)
}

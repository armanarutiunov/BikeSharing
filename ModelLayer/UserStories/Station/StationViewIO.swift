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
    
    var parkBike: Action { get }
    
    /// Show bikes
    func showBikes(_ bikes: [Bike])
    
}

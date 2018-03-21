//
//  Location.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

public struct Location {
    public let latitude: Double
    public let longtitude: Double
    public let address: String
    
    public init(latitude: Double, longtitude: Double, address: String) {
        self.latitude = latitude
        self.longtitude = longtitude
        self.address = address
    }
}

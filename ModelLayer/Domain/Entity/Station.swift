//
//  Station.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

public struct Station {
    public let id: Int
    public let location: Location
    public let bikes: [Bike]
    public let capacity = 30
    
    public init(id: Int, location: Location, bikes: [Bike]) {
        self.id = id
        self.location = location
        self.bikes = bikes
    }
    
    public var freeSpace: Int {
        return capacity - bikes.count
    }
    
    public var isFull: Bool {
        return freeSpace == 0
    }
    
    public var isEmpty: Bool {
        return bikes.count == 0
    }
}

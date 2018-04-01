//
//  Bike.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

public struct Bike {
    public let id: Int
    public var stationId: Int
    public let name: String
    public let frameColor: FrameColor
    public let pin: Int
    public var bookingExpiration: TimeInterval?
    
    public init(id: Int, stationId: Int, name: String, frameColor: FrameColor, pin: Int) {
        self.id = id
        self.stationId = stationId
        self.name = name
        self.frameColor = frameColor
        self.pin = pin
    }
    
    public var color: UIColor {
        switch frameColor {
        case .blue:
            return UIColor.cobiBlue
        case .green:
            return UIColor.greenBike
        case .red:
            return UIColor.redBike
        }
    }
}

public enum FrameColor: String {
    case blue, red, green
}

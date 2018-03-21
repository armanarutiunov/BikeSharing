//
//  Bike.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

public struct Bike {
    public let id: Int
    public let name: String
    public let frameColor: FrameColor
    public let pin: Int
    public let icon = #imageLiteral(resourceName: "bike")
    
    public init(id: Int, name: String, frameColor: FrameColor, pin: Int) {
        self.id = id
        self.name = name
        self.frameColor = frameColor
        self.pin = pin
    }
}

public enum FrameColor {
    case blue, red, green
}

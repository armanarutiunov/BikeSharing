//
//  StationSceneNavigator.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import ModelLayer

class StationSceneNavigator: BaseNavigator, StationNavigator {
    
    private var lastPushTimeStamp: TimeInterval = 10
    
    func back() {
        scene.pop()
    }
    
    func toBooking() {
        let lastPushTime = Date().timeIntervalSince1970 - lastPushTimeStamp
        if lastPushTime > 2 {
            lastPushTimeStamp = Date().timeIntervalSince1970
            scene.push(BookingScene())
        }
    }
}

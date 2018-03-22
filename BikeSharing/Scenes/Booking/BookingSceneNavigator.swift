//
//  BookingSceneNavigator.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 22/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import ModelLayer

class BookingSceneNavigator: BaseNavigator, BookingNavigator {
    func back() {
        scene.pop()
    }
}

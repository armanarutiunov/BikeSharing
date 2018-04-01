//
//  MockStationNavigator.swift
//  ModelLayerTests
//
//  Created by Arman Arutyunov on 23/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import ModelLayer
import RxSwift
import RxCocoa

class MockStationNavigator: StationNavigator {
    
    var _back: () -> Void = {}
    func back() { _back() }
    
    var _toBooking: () -> Void = {}
    func toBooking() { _toBooking() }
    
}

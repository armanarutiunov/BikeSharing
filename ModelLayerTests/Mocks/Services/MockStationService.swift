//
//  MockStationService.swift
//  ModelLayerTests
//
//  Created by Arman Arutyunov on 23/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import ModelLayer
import RxSwift

class MockStationService: StationService {
    
    var _getStations = PublishSubject<[Station]>()
    func getStations() -> Observable<[Station]> { return _getStations }
    
}

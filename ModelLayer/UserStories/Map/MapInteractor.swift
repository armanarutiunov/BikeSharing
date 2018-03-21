//
//  MapInteractor.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift

public class MapInteractor: Interactor {
    
    private let stationService: StationService
    
    public init(executors: Executors, stationService: StationService) {
        self.stationService = stationService
        super.init(executors: executors)
    }
    
    public func getStations() -> Observable<[Station]> {
        return applySchedulers(
            stationService.getStations()
        )
    }
}

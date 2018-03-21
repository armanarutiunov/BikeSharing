//
//  DataLayerAssembly.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import Swinject
import ModelLayer
import DataLayer

/**
 DataLayer assembler. Builds services and use cases.
 */
class DataLayerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Executors.self) { _ in StandardExecutors() }
        container.register(StationService.self) { _ in StubStationService() }
    }
}

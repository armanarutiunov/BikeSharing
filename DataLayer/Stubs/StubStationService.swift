//
//  StubStationService.swift
//  DataLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import ModelLayer
import RxSwift

public class StubStationService: StationService {
    public init() {}
    
    public func getStations() -> Observable<[Station]> {
        let bikes = [Bike(id: 23985742, stationId: 24028, name: "Kona", frameColor: .blue, pin: 2342),
                     Bike(id: 23948723, stationId: 24028, name: "KHS", frameColor: .green, pin: 2874),
                     Bike(id: 23942934, stationId: 24028, name: "Giant", frameColor: .red, pin: 2956),
                     Bike(id: 45867944, stationId: 24028, name: "Bianchi", frameColor: .red, pin: 6037),
                     Bike(id: 20572984, stationId: 24028, name: "Electra", frameColor: .green, pin: 0381),
                     Bike(id: 01875398, stationId: 24028, name: "Fuji", frameColor: .blue, pin: 5810),
                     Bike(id: 13466346, stationId: 24028, name: "Cinelli", frameColor: .blue, pin: 5830),
                     Bike(id: 13644039, stationId: 24028, name: "Foffa", frameColor: .green, pin: 4927),
                     Bike(id: 24643631, stationId: 24028, name: "Haro", frameColor: .red, pin: 5939),
                     Bike(id: 51342959, stationId: 24028, name: "Bianchi", frameColor: .blue, pin: 5838),
                     Bike(id: 98345395, stationId: 24028, name: "Electra", frameColor: .red, pin: 2959),
                     Bike(id: 37458328, stationId: 24028, name: "KHS", frameColor: .green, pin: 4894),
                     Bike(id: 36134507, stationId: 24028, name: "Fuji", frameColor: .green, pin: 3976),
                     Bike(id: 19326549, stationId: 24028, name: "Foffa", frameColor: .blue, pin: 2840),
                     Bike(id: 43810565, stationId: 24028, name: "Giant", frameColor: .red, pin: 0568)]
        
        let stations = [
            Station(id: 24028,
                    location: Location(latitude: 50.158761,
                                       longtitude: 8.687875,
                                       address: "K819, 60435 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 34957,
                    location: Location(latitude: 50.172977,
                                       longtitude: 8.62796,
                                       address: "Max-von-Laue-Straße 13, 60438 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 30498,
                    location: Location(latitude: 50.093772,
                                       longtitude: 8.691139,
                                       address: "Marie-Curie-Straße 13, 60439 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 28339,
                    location: Location(latitude: 50.17176,
                                       longtitude: 8.631976,
                                       address: "Marie-Curie-Straße 9-11, 60439 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 45094,
                    location: Location(latitude: 50.174159,
                                       longtitude: 8.633986,
                                       address: "Altenhöferallee 1, 60438 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 34890,
                    location: Location(latitude: 50.169753,
                                       longtitude: 8.640865,
                                       address: "Lurgiallee 12, 60439 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 23501,
                    location: Location(latitude: 50.164618,
                                       longtitude: 8.642783,
                                       address: "Zeilweg, 60439 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 23598,
                    location: Location(latitude: 50.163567,
                                       longtitude: 8.655008,
                                       address: "Im Uhrig, 60433 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 23492,
                    location: Location(latitude: 50.161501,
                                       longtitude: 8.649583,
                                       address: "Maybachbrücke, 60439 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 56098,
                    location: Location(latitude: 50.158073,
                                       longtitude: 8.654612,
                                       address: "Maybachstraße, 60433 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 28395,
                    location: Location(latitude: 50.160574,
                                       longtitude: 8.661462,
                                       address: "Anne-Frank-Straße, 60433 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 35972,
                    location: Location(latitude: 50.156333,
                                       longtitude: 8.661727,
                                       address: "Nußzeil 60, 60433 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 34598,
                    location: Location(latitude: 50.149763,
                                       longtitude: 8.660312,
                                       address: "Chamissostraße, 60431 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 23598,
                    location: Location(latitude: 50.147038,
                                       longtitude: 8.661626,
                                       address: "Hügelstraße 177, 60431 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 30958,
                    location: Location(latitude: 50.149124,
                                       longtitude: 8.618692,
                                       address: "Heerstraße 9, 60488 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 23895,
                    location: Location(latitude: 50.103084,
                                       longtitude: 8.656932,
                                       address: "Mannheimer Str. 85, 60327 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 12090,
                    location: Location(latitude: 50.101769,
                                       longtitude: 8.681028,
                                       address: "Diesterwegstraße 4, 60594 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 45894,
                    location: Location(latitude: 50.106179,
                                       longtitude: 8.687044,
                                       address: "Elisabethenstraße, 60594 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 65879,
                    location: Location(latitude: 50.100424,
                                       longtitude: 8.685798,
                                       address: "Diesterwegpl., 60594 Frankfurt am Main, Germany"),
                    bikes: bikes),
            Station(id: 23017,
                    location: Location(latitude: 50.093772,
                                       longtitude: 8.691139,
                                       address: "Darmstädter Landstraße, 60598 Frankfurt am Main, Germany"),
                    bikes: bikes)
        ]
        
        var updatedStations = [Station]()
        for station in stations {
            var bikes = [Bike]()
            for bike in station.bikes {
                let newBike = Bike(id: bike.id, stationId: station.id, name: bike.name, frameColor: bike.frameColor, pin: bike.pin)
                bikes.append(newBike)
            }
            let newStation = Station(id: station.id, location: station.location, bikes: bikes)
            updatedStations.append(newStation)
        }
        
        return Observable.just(stations)
    }
}

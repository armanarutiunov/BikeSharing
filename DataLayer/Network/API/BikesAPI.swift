//
//  BikesAPI.swift
//  DataLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import Moya
import ModelLayer

public enum BikesAPI {
    case getStations
    case getBikes(stationId: Int)
    case bookBike(stationId: Int, bikeId: Int)
    case rideBike(stationId: Int, bikeId: Int)
    case endRide(stationId: Int, bikeId: Int)
}

extension BikesAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://bikesharing.com/api/v1/")!
    }
    
    public var path: String {
        switch self {
        case .getStations:
            return "stations/get"
        case .getBikes(let stationId):
            return "stations/\(stationId)/get"
        case .bookBike(let stationId, let bikeId):
            return "stations/\(stationId)/bikes/\(bikeId)/book"
        case .rideBike(let stationId, let bikeId):
            return "stations/\(stationId)/bikes/\(bikeId)/ride"
        case .endRide(let stationId, let bikeId):
            return "stations/\(stationId)/bikes/\(bikeId)/return"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data() //stub
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}

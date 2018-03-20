//
//  Response+Parse.swift
//  DataLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import ModelLayer
import Moya
import Gloss

extension Response {
    func parse<T>() throws -> T where T: Gloss.JSONDecodable {
        guard
            let jsonData = try? mapJSON() as? [String: Any],
            let json = jsonData
            else { throw NetworkError.badResponse }
        
        guard let o = T(json: json) else { throw NetworkError.badResponse }
        return o
    }
    
    func parseArray<T>() throws -> [T] where T: Gloss.JSONDecodable {
        guard
            let jsonData = try? mapJSON() as? [[String: Any]],
            let json = jsonData
            else { throw NetworkError.badResponse }
        
        var result = [T]()
        for dict in json {
            guard let o = T(json: dict) else { throw NetworkError.badResponse }
            result.append(o)
        }
        
        return result
    }
}

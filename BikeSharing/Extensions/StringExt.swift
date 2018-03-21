//
//  StringExt.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    var string: String {
        let mins = Int(self) / 60 % 60
        let secs = Int(self) % 60
        return String(format: "%02i:%02i", mins, secs)
    }
    
}

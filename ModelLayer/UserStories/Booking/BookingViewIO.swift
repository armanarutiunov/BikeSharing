//
//  BookingViewIO.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 22/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

public protocol BookingViewIO: ViewIO {
    
    /// Back button pressed
    var backButtonPressed: Action { get }
    
    /// Start tide button pressed
    var startRideButtonPressed: Action { get }
    
    /// Timer finished
    var timerFinished: Action { get }
    
    /// When booking is expired user pressed OK on alert
    var alertOkPressed: Action { get }
    
    /// Show title
    func showTitle(_ title: String)
    
    /// Configure bike color
    func configureBikeColor(_ color: UIColor)
    
    /// Show when the booking will expire
    func showTimeLeft(_ time: TimeInterval)
    
    /// Show pin code for bike unlocking
    func showPin(_ pin: String)
    
    /// Show alert that booking is expired
    func showExpirationAlert()
    
}

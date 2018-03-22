//
//  BookingInteractor.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 22/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

public class BookingInteractor: Interactor {
    
    let bookingService: BookingService
    
    public init(executors: Executors, bookingService: BookingService) {
        self.bookingService = bookingService
        super.init(executors: executors)
    }
}

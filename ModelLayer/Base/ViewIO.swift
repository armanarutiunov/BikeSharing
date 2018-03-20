//
//  ViewIO.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

/// Marker protocol for views
public protocol ViewIO : class {
    /// Indicate loading progress
    ///
    /// - Parameter loading: whether there is blocking operation going on
    func show(loading: Bool)
}


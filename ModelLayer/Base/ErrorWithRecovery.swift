//
//  ErrorWithRecovery.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

/// An error with description that could optionally be recovered from
public typealias RecoveryAction = (() -> Void)

public struct ErrorWithRecovery {
    public private(set) var retryAction: RecoveryAction?
    public private(set) var cancelAction: RecoveryAction?
    
    public let description: String
    
    public init(_ description: String,
                retryAction:  RecoveryAction? = nil,
                cancelAction: RecoveryAction? = nil) {
        self.description = description
        self.retryAction = retryAction
        self.cancelAction = cancelAction
    }
}


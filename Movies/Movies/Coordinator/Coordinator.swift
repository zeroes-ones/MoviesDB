//
//  Coordinator.swift
//  MoviesSearch
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

/// Base abstract coordinator generic over the return type of the `start` method.
protocol Coordinator {
    /// Starts job of the coordinator.
    func start()
}

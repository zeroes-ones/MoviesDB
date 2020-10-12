//
//  AppCoordinator.swift
//  MoviesSearch
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

/// Handle all app level resources
final class AppCoordinator {

    private let launchOptions: [UIApplication.LaunchOptionsKey: Any]?

    init(
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        self.launchOptions = launchOptions
    }
}

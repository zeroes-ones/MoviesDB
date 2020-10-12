//
//  SceneCoordinator.swift
//  MoviesSearch
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

final class SceneCoordinator {

    private let window: UIWindow
    private let connectionOptions: UIScene.ConnectionOptions

    init(
        window: UIWindow,
        connectionOptions: UIScene.ConnectionOptions
    ) {
        self.window = window
        self.connectionOptions = connectionOptions
        let mainCoordinator =  MainCoordinator(destination: .moviesList(MoviesViewModel(MoviesAPIManager())))
        mainCoordinator.start()
        window.rootViewController = mainCoordinator.navigationViewController
        window.makeKeyAndVisible()
    }
}

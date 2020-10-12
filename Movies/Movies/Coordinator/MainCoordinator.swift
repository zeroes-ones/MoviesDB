//
//  MainCoordinator.swift
//  MoviesSearch
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit

struct MainCoordinator {
    private let navigator: PhotosNaviator

    var navigationViewController: UINavigationController? {
        navigator.navigationController
    }

    init(rootViewController: UIViewController? = nil, destination: Destination) {
        var navigator: PhotosNaviator {
            switch destination {
            case let .moviesList(moviesModel):
                return PhotosNaviator(root: rootViewController, destination: .MoviesImageList(moviesModel), navigationType: .push)
            }
        }
        self.navigator = navigator
    }

    func start() {
        navigator.navigate()
    }
}

extension MainCoordinator {
    enum Destination {
        case moviesList(MoviesViewModel)
    }
}

//
//  PhotosNavigator.swift
//  MoviesSearch
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

final class PhotosNaviator: Navigator {
    private weak var rootViewController: UIViewController?
    private let destination: Destination
    private let navigationType: NavigationType
    private(set) weak var navigationController: UINavigationController?
    init(
        root: Presentable?,
        destination: Destination,
        navigationType: NavigationType
    ) {
        self.rootViewController = root
        self.destination = destination
        self.navigationType = navigationType
    }

    func popToRootView() {
        rootViewController?.navigationController?.popToRootViewController(animated: true)
    }

    func navigate() {
        navigate(to: destination, type: navigationType)
    }
}

extension PhotosNaviator {
    enum Destination {
        case MoviesImageList(MoviesViewModel)
        case movie(movie: Movies.Movie, imageCache: ImageCache, fullScreen: Bool)
    }

    func navigate(
        to destination: Destination,
        type: NavigationType = .push
    ) {
        guard let viewController = makeViewController(for: destination) else {
            return
        }
        switch type {
        case .push:
            guard let navigationController = rootViewController?.navigationController else {
                self.navigationController = UINavigationController(rootViewController: viewController)
                rootViewController = viewController
                return
            }
            navigationController.pushViewController(viewController, animated: true)
        case .present:
            rootViewController?.present(viewController, animated: true)
        }
    }
}

private extension PhotosNaviator {
    func makeViewController(
        for destination: Destination
    ) -> UIViewController? {
        switch destination {
        case let .MoviesImageList(viewModel):
            return MoviesSearchViewController.makeViewController(viewModel: viewModel, navigator: self)
        case let .movie(movie, imageCache, fullScreen):
            return UIHostingController(rootView: MoviesImageViewCell(movie: movie, imageCache: imageCache, isFullScreen: fullScreen))
        }
    }
}

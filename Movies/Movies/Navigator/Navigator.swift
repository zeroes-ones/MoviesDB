//
//  Navigator.swift
//  MoviesSearch
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//
import UIKit
public typealias Presentable = UIViewController

public enum NavigationType {
    case push
    case present
}

protocol Navigator {
    associatedtype Destination
    init(
        root: Presentable?,
        destination: Destination,
        navigationType: NavigationType
    )
    func handle(error: Error)
}

extension Navigator {
    func handle(error: Error) { }
}

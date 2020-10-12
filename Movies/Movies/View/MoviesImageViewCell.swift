//
//  MoviesImageViewCell.swift
//  MoviesSearch
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import SwiftUI

struct MoviesImageViewCell {
    let movie: Movies.Movie
    var imageCache: ImageCache
    @State var isFullScreen = false
    private let imageSize: CGFloat = 120
    private let imageCornerRadius: CGFloat = 4
}

extension MoviesImageViewCell: View {
    var body: some View {
        ///from swift version >= 5.3, where opaque return types are supported.
        VStack {
            imageView
            Text(movie.title ?? "")
                .lineLimit(1)
                .frame(width: 100, alignment: .center)
        }
    }

    private var imageView: some View {
        guard let url = movie.posterURL else {
            return AnyView(
                ActivityIndicator(style: .medium, color: .red, isAnimating: true)
                .aspectRatio(contentMode: isFullScreen ? .fill : .fit)
                .scaledToFit()
                .frame(width: imageSize, height: imageSize)
            )
        }
        let urlImage = URLImage(url: url, cache: imageCache, placeholder: Image(systemName: "slowmo"), configuration: { $0.resizable() })
            .aspectRatio(contentMode: isFullScreen ? .fill : .fit)
            .frame(width: imageSize, height: imageSize)
            .cornerRadius(imageCornerRadius)
        return AnyView(urlImage)
    }
}

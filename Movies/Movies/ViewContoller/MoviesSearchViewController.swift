//
//  MoviesSearchViewController.swift
//  MoviesSearch
//
//  Created by S on 10/11/20.
//  Copyright © 2020 S. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import SwiftUI

final class MoviesSearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: MoviesViewModel!
    private var navigator: PhotosNaviator?
    @Environment(\.imageCache) private var cache: ImageCache

    static func makeViewController(viewModel: MoviesViewModel, navigator: PhotosNaviator) -> MoviesSearchViewController {
        let vc = MoviesSearchViewController.instantiateFromStoryboard("Movies", storyboardId: "MoviesSearchViewController")
        vc.viewModel = viewModel
        vc.navigator = navigator
        return vc
    }
}

extension MoviesSearchViewController {
    override func viewDidLoad() {
        title = "Movies"
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        configureHierarchy()
        observeModelChanges()
        viewModel.fetchNowPlaying(isInitialLoad: true)
    }
}

private extension MoviesSearchViewController {

    func configureHierarchy() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        SwiftUICollectionViewCell<MoviesImageViewCell>.register(with: collectionView)
    }

    // Observes the data changes and upddates the UI
    func observeModelChanges() {
        viewModel.movies.producer
            .observe(on: QueueScheduler.main)
            .startWithValues { [weak self] newValues in
                guard let self = self else { return }
                self.collectionView.reloadData()
        }
    }

    // function to create compositional layout for collectionview
    private static func createLayout() -> UICollectionViewLayout {

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(2/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.supplementariesFollowContentInsets = true

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }

}

//MARK: - CollectionView DataSource Delegate
extension MoviesSearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movies.value[section].movies?.count ?? 0
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.movies.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movie = viewModel.movies.value[indexPath.section].movies?[indexPath.row] else {
                return UICollectionViewCell()
        }
        let cell = SwiftUICollectionViewCell<MoviesImageViewCell>.dequeue(
            from: collectionView,
            for: indexPath
        )
        cell.setView(MoviesImageViewCell(movie: movie, imageCache: cache))
        return cell
    }
}

//MARK: - CollectionView Delegate
extension MoviesSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = viewModel.movies.value[indexPath.section].movies?[indexPath.row] else {
            return
        }
        navigator?.navigate(to: .movie(movie: movie, imageCache: cache, fullScreen: true), type: .push)
    }
}

//MARK: - Searchbar Delegate
extension MoviesSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        searchBar.resignFirstResponder()
        viewModel.searchMovies(for: text)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

//MARK: - Scrollview Delegate
extension MoviesSearchViewController: UIScrollViewDelegate {

    //MARK :- Getting user scroll down event here
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height)){
                //Start locading new data from here
                viewModel.fetchMoreMovies()
            }
        }
    }

    // MARK :- Hide keyboard if active on searchbar
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}

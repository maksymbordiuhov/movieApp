//
//  ListMoviesViewController.swift
//  movieApp
//
//  Created by Maksym Bordiuhov on 08.05.2021.
//  Copyright © 2021 Maksym Bordiuhov. All rights reserved.
//

import UIKit

class ListMoviesViewController: UIViewController, MoviesViewInteractionLogic {

    private var viewModel = ListMoviesViewModel()

    @IBOutlet private weak var moviesView: MoviesView!
    
    // MARK: - Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = viewModel.viewTitle
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = viewModel.viewTitle
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSarchController()
        fetchMovies()
    }

    // MARK: - Setup

    private func setup() {
        moviesView.viewController = self
    }

    private func setupSarchController() {
        let searchMoviesViewController = SearchMoviesViewController(sender: self)
        searchMoviesViewController.view.layoutIfNeeded()
        let searchController = UISearchController(searchResultsController: searchMoviesViewController)
        searchController.searchResultsUpdater = searchMoviesViewController
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Movie title"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Display

    func fetchMovies(nextPage: Bool = false) {
        viewModel.fetchPopularMovies(nextPage: nextPage) { (movieViewModel) in
            DispatchQueue.main.async {
                self.moviesView.movies = movieViewModel.movies ?? []
                self.moviesView.collectionView.reloadData()
            }
        }
    }

    func fetchGenres() {
        viewModel.fetchGenres { (genres) in
            DispatchQueue.main.async {
                // TODO: show category filter
            }
        }
    }

    func displayMovieDetail(movie: Movie) {
        let controller = ShowMovieViewController(with: movie)
        guard let navigation = self.navigationController else { return }
        navigation.pushViewController(controller, animated: true)
    }

    // MARK: - Movies View Interaction Logic

    func didSelect(movie: Movie) {
        displayMovieDetail(movie: movie)
    }

    func loadMoreData() {
        fetchMovies(nextPage: true)
    }

    func refreshContent() {
        viewModel.movieViewModel = MovieViewModel()
        fetchMovies()
        self.moviesView.collectionView.refreshControl?.endRefreshing()
    }
}

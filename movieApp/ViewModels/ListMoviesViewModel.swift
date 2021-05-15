//
//  ListMoviesViewModel.swift
//  movieApp
//
//  Created by Maksym Bordiuhov on 08.05.2021.
//  Copyright © 2021 Maksym Bordiuhov. All rights reserved.
//

import UIKit

class ListMoviesViewModel {

    let viewTitle = "Popular Movies"
    let movieService = MovieService()
    let genreService = GenreService()
    var movieViewModel = MovieViewModel()
    var genres: [Genre] = []
    var isLoadingMoreData = false
}

// MARK: - Requests
extension ListMoviesViewModel {

    func fetchPopularMovies(nextPage: Bool, completion: @escaping (MovieViewModel) -> ()) {

        if isLoadingMoreData {
            return
        }

        isLoadingMoreData = true

        guard var page = self.movieViewModel.page else { return }

        if nextPage {
            guard let totalPages = self.movieViewModel.totalPages else { return }
            if page >= totalPages {
                isLoadingMoreData = false
                return
            }
            page += 1
        }

        self.movieService.fetchPopularMovies(with: page) {
            (viewModel, serviceError) in

            self.isLoadingMoreData = false

            if serviceError != nil {
                // TODO: Correct the error
                return
            }

            if let viewModel = viewModel {
                self.movieViewModel.page = viewModel.page
                self.movieViewModel.totalPages = viewModel.totalPages
                if nextPage {
                    self.movieViewModel.movies?.append(contentsOf: viewModel.movies ?? [])
                } else {
                    self.movieViewModel.movies = viewModel.movies
                }

                completion(self.movieViewModel)
            }
        }
    }

    func fetchGenres(completion: @escaping ([Genre]) -> ()) {
        self.genreService.fetchGenres { (genres, serviceError) in
            if serviceError != nil {
                // TODO: Correct the error
                return
            }

            if let genres = genres {
                self.genres = genres
                completion(genres)
            }
        }
    }
}

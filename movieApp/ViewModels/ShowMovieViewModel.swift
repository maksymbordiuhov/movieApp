//
//  ShowMovieViewModel.swift
//  movieApp
//
//  Created by Maksym Bordyugov on 08.05.2021.
//  Copyright © 2021 Maksym Bordyugov. All rights reserved.
//


import Foundation

class ShowMovieViewModel {

    var movie = Movie()
    let movieService = MovieService()
    let movieDataSource = MovieDataSource()
    var isFavorite = false
}

// MARK: - Requests
extension ShowMovieViewModel {

    func fetchMovie(completion: @escaping (Movie) -> ()) {
        guard let id = self.movie.id else { return }
        self.movieService.fetchMovie(with: id) {
            (movie, serviceError) in

            if serviceError != nil {
                // TODO: Correct the error
                return
            }

            if let movie = movie {
                self.movie.genres = movie.genres
                completion(self.movie)
            }
        }
    }

    func checkFavorite(completion: @escaping (Movie) -> ()) {
        movieDataSource.fetchMovie(movie: movie) { (movie, dataSourceError) in
            if dataSourceError != nil {
                self.isFavorite = false
            }

            if movie != nil {
                self.isFavorite = true
            }

            completion(self.movie)
        }
    }

    func tougleIsfavorite(completion: @escaping (Movie) -> ()) {
        if isFavorite {
            movieDataSource.removeMovie(movie: movie) { (movie, dataSourceError) in
                if dataSourceError != nil {
                    // TODO: Correct the error
                }

                self.isFavorite = false
                completion(self.movie)
            }
        } else {
            movieDataSource.saveMovie(movie: movie) { (movie, dataSourceError) in
                if dataSourceError != nil {
                    // TODO: Correct the error
                }

                self.isFavorite = true
                completion(self.movie)
            }
        }
    }
}

//
//  TabBarController.swift
//  movieApp
//
//  Created by Maksym Bordyugov on 08.05.2021.
//  Copyright © 2021 Maksym Bordyugov. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Object lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let listMoviesItem = UITabBarItem(
            title: "Movies",
            image: UIImage(named: "icon-film"),
            selectedImage: UIImage(named: "icon-film"))
        let listMoviesViewController = ListMoviesViewController(nibName: "ListMoviesViewController", bundle: nil)
        listMoviesViewController.tabBarItem = listMoviesItem
        let moviesNavigation = createNavigation(with: listMoviesViewController)

        let listFavoritesItem = UITabBarItem(
            title: "Favourites",
            image: UIImage(named: "icon-star"),
            selectedImage: UIImage(named: "icon-star"))
        let listfavoritesViewController = ListFavoritesViewController(nibName: "ListFavoritesViewController", bundle: nil)
        listfavoritesViewController.tabBarItem = listFavoritesItem
        let favoritesNavigation = createNavigation(with: listfavoritesViewController)

        self.viewControllers = [moviesNavigation, favoritesNavigation]
        self.selectedViewController = moviesNavigation
        self.selectedIndex = 0
        self.tabBar.barStyle = .black
        self.tabBar.tintColor = Constants.color().lightGreen
        self.tabBar.unselectedItemTintColor = .white
    }

    private func createNavigation(with viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigation.navigationBar.titleTextAttributes = textAttributes
        navigation.navigationBar.largeTitleTextAttributes = textAttributes
        navigation.navigationBar.barStyle = .black
        navigation.navigationBar.tintColor = .white

        return navigation
    }
}

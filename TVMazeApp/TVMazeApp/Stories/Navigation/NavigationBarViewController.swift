//
//  NavigationBarViewController.swift
//  TVMazeApp
//
//  Created by Digao on 09/02/22.
//

import Foundation
import UIKit

public class NavigationBarViewController: UITabBarController, UITabBarControllerDelegate {
    public override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .black
        tabBar.isTranslucent = false
        delegate = self
        configureTab()
    }
    
    private func configureTab() {
        
        let home = SeriesListViewController.newInstance(viewModel: SeriesListViewModel())
        let homeIcon = UIImage(systemName: "house.fill")
        home.tabBarItem = UITabBarItem(title: "Home", image: homeIcon, tag: 0)
        
        let search = SearchSeriesViewController(nibName: "SearchSeriesViewController", bundle: nil)
        let userIcon = UIImage(systemName: "magnifyingglass")
        search.tabBarItem = UITabBarItem(title: "Search", image: userIcon, tag: 2)
        
        self.setViewControllers([home, search], animated: false)
    }
}

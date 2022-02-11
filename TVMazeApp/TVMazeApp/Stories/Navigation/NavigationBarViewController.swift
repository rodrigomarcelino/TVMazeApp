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
        
        let home = ShowListViewController.newInstance(viewModel: ShowListViewModel())
        
        let homeIcon = UIImage(systemName: "house.fill")
        home.tabBarItem = UITabBarItem(title: "Home", image: homeIcon, tag: 0)
        
        let search = SearchShowViewController.newInstance(viewModel: SearchShowViewModel())
        let userIcon = UIImage(systemName: "magnifyingglass")
        search.tabBarItem = UITabBarItem(title: "Search", image: userIcon, tag: 2)
        
        self.setViewControllers([UINavigationController(rootViewController: home), UINavigationController(rootViewController: search)], animated: false)
    }
}

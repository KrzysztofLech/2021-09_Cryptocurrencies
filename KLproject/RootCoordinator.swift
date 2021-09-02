//
//  RootCoordinator.swift
//  KLproject
//
//  Created by KL on 02/09/2021.
//

import UIKit

protocol Coordinator {
    func start()
}

final class RootCoordinator: NSObject, Coordinator {
    
    // MARK: - Properties -
    
    private var window: UIWindow?
    private var navigationController: UINavigationController?
        
    // MARK: - Init -
    
    init(windowScene: UIWindowScene) {
        self.window = UIWindow(windowScene: windowScene)
    }
    
    // MARK: - Module methods -
    
    func start() {
        showList()
    }
    
    private func showList() {
        let listViewModel = ListViewModel()
        let listViewController = ListViewController(viewModel: listViewModel)
        listViewController.delegate = self
        
        navigationController = UINavigationController(rootViewController: listViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

// MARK: - ListViewController delegate methods -

extension RootCoordinator: ListViewControllerDelegate {
}

//
//  SceneDelegate.swift
//  KLproject
//
//  Created by KL on 02/09/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var rootCoordinator: RootCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        rootCoordinator = RootCoordinator(windowScene: windowScene)
        rootCoordinator?.start()
    }
}

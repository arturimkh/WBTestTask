//
//  SceneDelegate.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 31.08.2023.
//

import UIKit
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let nav1 = UINavigationController()
        let mainView = WBListRegionsViewController(nibName: nil, bundle: nil)
        nav1.viewControllers = [mainView]
        window?.makeKeyAndVisible()
        window?.rootViewController = nav1
    }

}


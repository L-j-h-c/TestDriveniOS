//
//  SceneDelegate.swift
//  BasicTest
//
//  Created by Junho Lee on 2022/11/05.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let rootViewController = UINavigationController(rootViewController: RootViewCowntroller())
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = rootViewController
        self.window = window
        window.backgroundColor = .white
        window.makeKeyAndVisible()
    }
}


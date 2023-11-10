//
//  SceneDelegate.swift
//  ArtList
//
//  Created by Kirill Taraturin on 07.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let mainVC = UINavigationController(rootViewController: AuthorsListViewController())
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
    
    func toggleAppearance(animated: Bool) {
        guard let window = self.window else { return }
        
        let style: UIUserInterfaceStyle = window.overrideUserInterfaceStyle == .dark ? .light : .dark
        
        if animated {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.overrideUserInterfaceStyle = style
            })
        } else {
            window.overrideUserInterfaceStyle = style
        }
    }
}


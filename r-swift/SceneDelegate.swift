//
//  SceneDelegate.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-08.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, WindowProviding {

    var window: UIWindow?

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        set(rootViewController: ViewController())
        window?.windowScene = windowScene
    }
}

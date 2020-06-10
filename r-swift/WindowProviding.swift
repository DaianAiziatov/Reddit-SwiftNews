//
//  WindowProviding.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-08.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import UIKit

protocol WindowProviding: AnyObject {
    var window: UIWindow? { get set }
}

extension WindowProviding {
    func set(rootViewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

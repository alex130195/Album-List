//
//  AppDelegate.swift
//  Album List
//
//  Created by Alex Poddubnyy on 11.10.17.
//  Copyright © 2017 Alex Poddubnyy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let albumListViewController = AlbumListViewController(nibName: "AlbumListViewController", bundle: nil)
        let navigationController = UINavigationController.init(rootViewController: albumListViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}


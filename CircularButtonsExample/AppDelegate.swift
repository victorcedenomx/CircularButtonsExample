//
//  AppDelegate.swift
//  CircularButtonsExample
//
//  Created by Víctor Cedeño on 5/16/18.
//  Copyright © 2018 Víctor Cedeño Naranjo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
    
    // MARK: - Internal properties
    
    var window: UIWindow?
    
    // MARK: - Private functions
    
    fileprivate func setupWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.rootViewController = UINavigationController(rootViewController: FirstViewController())
        self.window?.makeKeyAndVisible()
    }
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.setupWindow()
        return true
    }
}

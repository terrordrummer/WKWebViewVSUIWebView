//
//  AppDelegate.swift
//  ResizableebViewPOC
//
//  Created by Roberto Sartori on 26.3.20.
//  Copyright © 2020 Roberto Sartori. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)

        guard let window = window else{

            return false

        }

        let mainController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window.rootViewController = mainController
        window.makeKeyAndVisible()

        return true
    }

}


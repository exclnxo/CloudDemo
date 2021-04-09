//
//  AppDelegate.swift
//  CloudDemo
//
//  Created by mac on 2021/4/9.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let nvc = UINavigationController(rootViewController: ViewController())
        window = UIWindow()
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
        
        return true
    }


}


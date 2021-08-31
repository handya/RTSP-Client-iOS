//
//  AppDelegate.swift
//  RtspClient
//
//  Created by Teocci on 18/05/16.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TileViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

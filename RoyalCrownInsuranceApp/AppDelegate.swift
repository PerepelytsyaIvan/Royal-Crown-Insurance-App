//
//  AppDelegate.swift
//  RoyalCrownInsuranceApp
//
//  Created by Dream Store on 23.06.2020.
//  Copyright © 2020 Perepelitsia. All rights reserved.
//

import UIKit
import GoogleMaps
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBH_9Jev7BOIFJaH14oHNkI-oPQn7CsbpQ")
        return true
    }
}


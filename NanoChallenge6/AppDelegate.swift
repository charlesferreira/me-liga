//
//  AppDelegate.swift
//  NanoChallenge6
//
//  Created by Charles Ferreira on 06/03/2018.
//  Copyright © 2018 Charles Ferreira. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupSession()
        
        return true
    }
    
    private func setupSession() {
        WCSession.default.delegate = self
        WCSession.default.activate()
    }
}

extension AppDelegate: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
}


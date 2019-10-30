//
//  AppDelegate.swift
//  iCalculator
//
//  Created by Abel Lazaro on 30/10/19.
//  Copyright © 2019 Abel Lázaro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //setup
        setupView()
        
        return true
    }

    //MARK: - funciones privadas
    
    private func setupView() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
    }
    
}


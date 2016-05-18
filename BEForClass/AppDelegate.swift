//
//  AppDelegate.swift
//  BEForClass
//
//  Created by Thomas Crawford on 5/15/16.
//  Copyright © 2016 VizNetwork. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let APP_ID = "69235504-4003-83C6-FF8A-D67CA7C52800"
    let SECRET_KEY = "B1034CC7-F44D-4722-FF78-499CD4B99300"
    let VERSION_NUM = "v1"
    
    var backendless = Backendless.sharedInstance()
    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        backendless.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
        return true
    }

}


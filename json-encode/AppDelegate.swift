//
//  AppDelegate.swift
//  json-encode
//
//  Created by Hung Le on 6/15/16.
//  Copyright © 2016 Hung Le. All rights reserved.
//

import UIKit
import JSONCodable

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let path = NSBundle.mainBundle().pathForResource("test", ofType: "json")
        let data = NSData.init(contentsOfFile: path!) as NSData!
        
        let user : User
        let user2: User
        do {
            user = try User.createFromJSONData(data)
            user2 = try User(object: NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! JSONObject)
            print("user: \(user)")
            let anyObject = try! user.toJSON()
            let anyObject2 = try! user2.toJSON()
            print("object: \(anyObject)")
            print("object: \(anyObject2)")
        } catch {
            print("error: \(error)")
        }
        
        return true
    }

}


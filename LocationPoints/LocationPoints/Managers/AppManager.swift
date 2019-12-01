//
//  AppManager.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 18.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import GoogleMaps
import GooglePlaces

typealias VoidCompletionBlock = (() -> ())?
typealias ErrorCompletionBlock = ((Error?) -> ())?
typealias JSON = [String: Any]

fileprivate let google_map_api_key = "AIzaSyC71--X46rdRsoikcRoOQEtAZNYTbJ583Q"
fileprivate let clientID = "917360643499-img1m8a075djhr7pjagc7hlmrhrj04pb.apps.googleusercontent.com"

class AppManager {
    
    static let RTDB = LPDatabase.shared
    
    static func config(_ session: UISceneSession) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: session.role)
    }
    
    static func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        GIDSignIn.sharedInstance()?.clientID = clientID
        GMSServices.provideAPIKey(google_map_api_key)
        GMSPlacesClient.provideAPIKey(google_map_api_key)
        return true
    }
    static func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance()?.handle(url) ?? false
    }
}

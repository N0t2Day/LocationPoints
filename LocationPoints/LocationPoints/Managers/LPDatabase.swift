//
//  LPDatabase.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 18.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import Foundation
import FirebaseDatabase
fileprivate let const_points = "points"
typealias Points = [LPPoint]

let DataDidUpdateNotification: Notification.Name = Notification.Name(rawValue: "didUpdateDataNotificationName")
class LPDatabase {
    static let shared = LPDatabase()
    let ref = Database.database().reference()
    lazy var points_ref: DatabaseReference = {
         ref.child(const_points)
    }()
    
    var items: Points = [] {
        didSet {
            NotificationCenter.default.post(name: DataDidUpdateNotification, object: nil)
        }
    }
    
    
    private init() {beginObservePoints()}
    func beginObservePoints() {
        points_ref.observe(.value) {[weak self] snapshot in
            var newItems: Points = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                  let point = LPPoint(snapshot: snapshot) {
                  newItems.append(point)
                }
            }
            self?.items = newItems
        }
    }
    
    func insertNewPoint(name: String, longitude: Double, latitude: Double) throws {
        let child = points_ref.childByAutoId()
        let point = LPPoint(name:name, longitude: longitude, latitude:latitude, id: UUID().uuidString.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range: nil).lowercased())
        child.setValue( try point.asJSON())
    }
    
}

//
//  LPPoint.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 19.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

let kyiv_latitude = 50.431782
let kyiv_longitude = 30.516382
struct LPPoint: Codable {
    
    enum DecomposeKeys: String, CaseIterable, CodingKey {
        case name, longitude, latitude, id
        var decomposeKey: String {
            switch self {
            default: return self.rawValue
            }
        }
    }
    
    
    var name: String = "n/a"
    var longitude: Double?
    var latitude: Double?
    var id: String?
    var ref: DatabaseReference?
    init(name: String, longitude: Double, latitude: Double, id: String) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.id = id
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
      guard let value = snapshot.value as? [String: AnyObject] else {
        return nil
      }
        self.init(json: value)
        self.ref = snapshot.ref
    }
    
    init?(json: JSON) {
        DecomposeKeys.allCases.forEach {
            if json.keys.contains($0.decomposeKey) {
                switch $0 {
                case .name: self.name = json.value($0.decomposeKey) ?? ""
                case .longitude: self.longitude = json.value($0.decomposeKey)
                case .latitude: self.latitude = json.value($0.decomposeKey)
                case .id: self.id = json.value($0.decomposeKey)
                }
            }
        }
    }
    func asJSON() throws -> Any {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(self)
        return try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecomposeKeys.self)
        name = try container.decode(String.self, forKey: .name)
        longitude = try container.decode(Double?.self, forKey: .longitude)
        latitude = try container.decode(Double?.self, forKey: .latitude)
        id = try container.decode(String?.self, forKey: .id)

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DecomposeKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(id, forKey: .id)
    }
}
extension LPPoint {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude ?? kyiv_latitude, longitude: self.longitude ?? kyiv_longitude)
    }
}

extension LPPoint: InfoObject {
    
    var title: String { self.name }
    
    var subTitle: String? { "Longitude \(longitude ?? 0.0)" }
    
    var detailText: String? { "Latitude \(latitude ?? 0.0)" }
}
extension LPPoint: Comparable {
    static func < (lhs: LPPoint, rhs: LPPoint) -> Bool { return lhs.name < rhs.name }
    
    
}

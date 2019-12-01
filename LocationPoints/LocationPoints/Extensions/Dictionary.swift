//
//  Dictionary.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 19.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import Foundation

extension Dictionary where Key == String {
    func value<T>(_ key: String) -> T? {
        return self[key] as? T
    }
}

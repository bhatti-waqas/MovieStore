//
//  Dictionary.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

extension Dictionary where Key == String, Value == Any {
    mutating func append<Key:RawRepresentable>(_ key:Key, _ value:Any?) where Key.RawValue == String {
        if let value = value {
            self[key.rawValue] = value
        }
    }
}

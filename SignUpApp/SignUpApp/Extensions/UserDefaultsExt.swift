//
//  UserDefaultsExt.swift
//  SignUpApp
//
//  Created by Евгений Забродский on 24.11.22.
//

import Foundation

extension UserDefaults {
    enum Keys: String, CaseIterable {
        case email
        case name
        case password
    }
    
    func reset() {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue)}
    }
}

//
//  UserDefaults+.swift
//  
//
//  Created by Alex Nagy on 13/06/2020.
//

import Foundation

public extension UserDefaults {
    
    static func clear() {
        print("Clearing UserDefaults...")
        let domain = Bundle.main.bundleIdentifier!
        standard.removePersistentDomain(forName: domain)
        standard.synchronize()
        list()
    }
    
    static func list() {
        let count = standard.dictionaryRepresentation().keys.count
        let keys = Array(standard.dictionaryRepresentation().keys)
        let values = Array(standard.dictionaryRepresentation().values)
        print("--------- UserDefaults ---------")
        for i in 0..<count {
            print("\(keys[i]) -> \(values[i])")
        }
        print("--------- UserDefaults End ---------")
    }
    
    static func onFirst(_ key: String, reset: Bool = false, completion: @escaping () -> ()) {
        if !standard.bool(forKey: key) {
            standard.set(!reset, forKey: key)
            completion()
        }
    }
    
    static func onFirstLaunch(reset: Bool = false, completion: @escaping () -> ()) {
        onFirst("launch", reset: reset, completion: completion)
    }
    
}

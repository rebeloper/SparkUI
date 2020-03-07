//
//  SUserDefaults.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import Foundation

public struct SUserDefaults {
    
    public static func clear() {
        print("Clearing UserDefaults...")
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        list()
    }
    
    public static func list() {
        let count = UserDefaults.standard.dictionaryRepresentation().keys.count
        let keys = Array(UserDefaults.standard.dictionaryRepresentation().keys)
        let values = Array(UserDefaults.standard.dictionaryRepresentation().values)
        print("--------- sUserDefaults ---------")
        for i in 0..<count {
            print("\(keys[i]) -> \(values[i])")
        }
        print("--------- sUserDefaults End ---------")
    }
    
}

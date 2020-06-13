//
//  SUserDefaults.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import Foundation

public struct CodableUserDefaults {
    
    static func clear() {
        print("Clearing CodableUserDefaults...")
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        list()
    }
    
    static func list() {
        let count = UserDefaults.standard.dictionaryRepresentation().keys.count
        let keys = Array(UserDefaults.standard.dictionaryRepresentation().keys)
        let values = Array(UserDefaults.standard.dictionaryRepresentation().values)
        print("--------- CodableUserDefaults ---------")
        for i in 0..<count {
            print("\(keys[i]) -> \(values[i])")
        }
        print("--------- CodableUserDefaults End ---------")
    }
    
    static var wasFirstLaunch = SUserDefault(key: "wasFirstLaunch", initialValue: false)
    
    static func onFirstLaunch(completion: @escaping () -> ()) {
        if !wasFirstLaunch.wrappedValue {
            wasFirstLaunch.wrappedValue = true
            print("CodableUserDefaults: wasFirstLaunch.wrappedValue = true")
            completion()
        } else {
            print("CodableUserDefaults: wasFirstLaunch.wrappedValue = false")
        }
    }
    
    static func resetFirstLaunch() {
        wasFirstLaunch.wrappedValue = false
        print("CodableUserDefaults: reset wasFirstLaunch.wrappedValue = false")
    }
    
}

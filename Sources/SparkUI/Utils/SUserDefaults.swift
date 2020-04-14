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
        print("--------- UserDefaults ---------")
        for i in 0..<count {
            print("\(keys[i]) -> \(values[i])")
        }
        print("--------- UserDefaults End ---------")
    }
    
    public static var wasFirstLaunch = SUserDefault(key: "wasFirstLaunch", initialValue: false)
    
    public static func doUponFirstLaunch(completion: @escaping () -> ()) {
        if !wasFirstLaunch.wrappedValue {
            wasFirstLaunch.wrappedValue = true
            print("UserDefaults: wasFirstLaunch.wrappedValue = true")
            completion()
        } else {
            print("UserDefaults: wasFirstLaunch.wrappedValue = false")
        }
    }
    
    public static func resetFirstLaunch() {
        wasFirstLaunch.wrappedValue = false
        print("UserDefaults: reset wasFirstLaunch.wrappedValue = false")
    }
    
}

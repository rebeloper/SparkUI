//
//  SInfoPlist.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import Foundation

public struct SInfoPlist {
    
    static public func getStringValue(forKey: String) -> String {
        guard let value = Bundle.main.infoDictionary?[forKey] as? String else {
            fatalError("No value found for key '\(forKey)' in the Info.plist file")
        }
        return value
    }
    
    static public func getBundleId() -> String {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            fatalError("could not find bundle id in the Info.plist file")
        }
        return bundleId
    }
    
}

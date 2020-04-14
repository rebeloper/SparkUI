//
//  SUserDefault.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import Foundation

@propertyWrapper
public struct SUserDefault<T: Codable> {
    private let key: String
    private let initialValue: T

    public init(key: String, initialValue: T) {
        self.key = key
        self.initialValue = initialValue
    }

    public var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return initialValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? initialValue
        }
        set {
            // Convert newValue to data
            let data = try? JSONEncoder().encode(newValue)
            
            // Set value to UserDefaults
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}


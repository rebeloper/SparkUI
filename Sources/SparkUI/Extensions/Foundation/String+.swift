//
//  String+.swift
//  
//
//  Created by Alex Nagy on 30/05/2020.
//

import Foundation

public extension String {
    static var empty = String()
    
    mutating func makeEmpty() {
        self = ""
    }
}

public extension String {
    func getFirstAndLastName() -> (String, String)? {
        var components = self.components(separatedBy: " ")
        if components.count > 0 {
            let firstName = components.removeFirst()
            let lastName = components.joined(separator: " ")
            return (firstName, lastName)
        }
        return nil
    }
}

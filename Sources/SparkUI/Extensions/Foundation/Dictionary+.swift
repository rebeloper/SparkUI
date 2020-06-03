//
//  Dictionary+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import Foundation

public extension Dictionary {
    
    mutating func update(with other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    
    static func empty() -> Dictionary {
        self.init()
    }
    
    mutating func makeEmpty() {
        self.removeAll()
    }
}

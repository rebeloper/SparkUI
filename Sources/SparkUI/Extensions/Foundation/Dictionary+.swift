//
//  Dictionary+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import Foundation

extension Dictionary {
    
    public mutating func update(with other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}

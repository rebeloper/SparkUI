//
//  String+.swift
//  
//
//  Created by Alex Nagy on 30/05/2020.
//

import Foundation

public extension String {
    static var empty: String = ""
    
    mutating func makeEmpty() {
        self = ""
    }
}

//
//  SelfConfiguringCell.swift
//  
//
//  Created by Alex Nagy on 21/02/2020.
//

import Foundation

public protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
}

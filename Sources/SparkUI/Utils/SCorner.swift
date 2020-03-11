//
//  SCorner.swift
//  
//
//  Created by Alex Nagy on 11/03/2020.
//

import UIKit

typealias SCornerMask = CACornerMask

public struct SCorner {
    public static let topLeft : SCornerMask = .layerMaxXMinYCorner
    public static let topRight : SCornerMask = .layerMinXMinYCorner
    public static let bottomLeft : SCornerMask = .layerMinXMaxYCorner
    public static let bottomRight : SCornerMask = .layerMaxXMaxYCorner
}


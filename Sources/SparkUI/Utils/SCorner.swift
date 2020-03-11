//
//  SCorner.swift
//  
//
//  Created by Alex Nagy on 11/03/2020.
//

import UIKit

public static var leftBottom     : CACornerMask { get { return .layerMinXMaxYCorner}}
public static var rightBottom    : CACornerMask { get { return .layerMaxXMaxYCorner}}
public static var leftTop        : CACornerMask { get { return .layerMaxXMinYCorner}}
public static var rightTop       : CACornerMask { get { return .layerMinXMinYCorner}}

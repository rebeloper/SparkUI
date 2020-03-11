//
//  SCorner.swift
//  
//
//  Created by Alex Nagy on 11/03/2020.
//

import UIKit

public var bottomLeftCorner     : CACornerMask { get { return .layerMinXMaxYCorner}}
public var bottomRightCorner    : CACornerMask { get { return .layerMaxXMaxYCorner}}
public var topLeftCorner        : CACornerMask { get { return .layerMaxXMinYCorner}}
public var topRightCorner       : CACornerMask { get { return .layerMinXMinYCorner}}

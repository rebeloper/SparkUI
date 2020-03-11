//
//  SCorner.swift
//  
//
//  Created by Alex Nagy on 11/03/2020.
//

import UIKit

public var topLeftCorner: CACornerMask { get { return .layerMaxXMinYCorner}}
public var topRightCorner: CACornerMask { get { return .layerMinXMinYCorner}}
public var bottomLeftCorner: CACornerMask { get { return .layerMinXMaxYCorner}}
public var bottomRightCorner: CACornerMask { get { return .layerMaxXMaxYCorner}}
public var topCorners: CACornerMask { get { return [.layerMaxXMinYCorner, .layerMinXMinYCorner]}}
public var bottomCorners: CACornerMask { get { return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]}}
public var leftCorners: CACornerMask { get { return [.layerMinXMaxYCorner, .layerMaxXMinYCorner]}}
public var rightCorners: CACornerMask { get { return [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]}}
public var allCorners: CACornerMask { get { return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]}}

//
//  SCorner.swift
//  
//
//  Created by Alex Nagy on 11/03/2020.
//

import UIKit

public var CACornerMask_topLeadingCorner: CACornerMask { get { return .layerMaxXMinYCorner}}
public var CACornerMask_topTrailingCorner: CACornerMask { get { return .layerMinXMinYCorner}}
public var CACornerMask_bottomLeadingCorner: CACornerMask { get { return .layerMinXMaxYCorner}}
public var CACornerMask_bottomTrailingCorner: CACornerMask { get { return .layerMaxXMaxYCorner}}
public var CACornerMask_topCorners: CACornerMask { get { return [.layerMaxXMinYCorner, .layerMinXMinYCorner]}}
public var CACornerMask_bottomCorners: CACornerMask { get { return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]}}
public var CACornerMask_leadingCorners: CACornerMask { get { return [.layerMinXMaxYCorner, .layerMaxXMinYCorner]}}
public var CACornerMask_trailingCorners: CACornerMask { get { return [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]}}
public var CACornerMask_allCorners: CACornerMask { get { return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]}}

//
//  SCorner.swift
//  
//
//  Created by Alex Nagy on 11/03/2020.
//

import UIKit

public var CACornerMask_topLeadingCorner: CACornerMask { get { return .layerMinXMinYCorner}}
public var CACornerMask_topTrailingCorner: CACornerMask { get { return .layerMaxXMinYCorner}}
public var CACornerMask_bottomLeadingCorner: CACornerMask { get { return .layerMinXMaxYCorner}}
public var CACornerMask_bottomTrailingCorner: CACornerMask { get { return .layerMaxXMaxYCorner}}

public var CACornerMask_topCorners: CACornerMask { get {
    return [CACornerMask_topLeadingCorner,
            CACornerMask_topTrailingCorner]}}
public var CACornerMask_bottomCorners: CACornerMask { get {
    return [CACornerMask_bottomLeadingCorner,
            CACornerMask_bottomTrailingCorner]}}
public var CACornerMask_leadingCorners: CACornerMask { get {
    return [CACornerMask_topLeadingCorner,
            CACornerMask_bottomLeadingCorner]}}
public var CACornerMask_trailingCorners: CACornerMask { get {
    return [CACornerMask_topTrailingCorner,
            CACornerMask_bottomTrailingCorner]}}

public var CACornerMask_topLeading_BottomTrailingCorners: CACornerMask { get {
    return [CACornerMask_topLeadingCorner,
            CACornerMask_bottomTrailingCorner]}}
public var CACornerMask_topTrailing_BottomLeadingCorners: CACornerMask { get {
    return [CACornerMask_topTrailingCorner,
            CACornerMask_bottomLeadingCorner]}}

public var CACornerMask_allCorners: CACornerMask { get {
    return [CACornerMask_topLeadingCorner,
            CACornerMask_topTrailingCorner,
            CACornerMask_bottomLeadingCorner,
            CACornerMask_bottomTrailingCorner]}}

public var CACornerMask_allCornersExeptTopLeading: CACornerMask { get {
    return [CACornerMask_topTrailingCorner,
            CACornerMask_bottomLeadingCorner,
            CACornerMask_bottomTrailingCorner]}}
public var CACornerMask_allCornersExeptTopTrailing: CACornerMask { get {
    return [CACornerMask_topLeadingCorner,
            CACornerMask_bottomLeadingCorner,
            CACornerMask_bottomTrailingCorner]}}
public var CACornerMask_allCornersExeptBottomLeading: CACornerMask { get {
    return [CACornerMask_topLeadingCorner,
            CACornerMask_topTrailingCorner,
            CACornerMask_bottomTrailingCorner]}}
public var CACornerMask_allCornersExeptBottomTrailing: CACornerMask { get {
    return [CACornerMask_topLeadingCorner,
            CACornerMask_topTrailingCorner,
            CACornerMask_bottomLeadingCorner]}}

//
//  Enums.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit

public enum TextStyle {
    case regular, bold, italic
}

public enum FontStyle {
    case largeTitle, title, headline, subheadline, body, callout, footnote, caption
}

public enum FontStyleSize: CGFloat {
    case largeTitle = 34, title = 27, headline = 17, subheadline = 14, body = 16, callout = 16.5, footnote = 13, caption = 11.5
}

public enum CapsuleBorderOrientation {
    case horizontal, vertical
}

public enum SCornerType {
    case topLeft, topRight, bottomLeft, bottomRight
}

public enum SAppearenceMode: Int {
    case none = 0, light = 1, dark = 2, preiOS13 = 3
}

public enum UIViewControllerModalPresentationStyle {
    case fill
    case sheet(topPadding: CGFloat = 60, topCornerRadius: CGFloat = 15)
    case intrinsic(topCornerRadius: CGFloat = 15)
    case constant(height: CGFloat, topCornerRadius: CGFloat = 15)
}

public enum UIViewControllerSwipeToDismissStyle {
    case disabled
    case enabled
    case sticky
}

public enum UIViewControllerAnimationType {
    case none
    case slide
    case fade(duration: TimeInterval = 0.25)
}

public enum SNavigatorActionType {
    case pushed
    case presented
}

public enum TabBarTag: Int {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
}

public enum SSide {
    case top, left, bottom, right
}

public enum AspectRatioBase {
    case width, height
}

public enum LongPressGestureState {
    case none, didBegin, pressing, didEnd
}

public enum Side {
    case width, height
}

public enum Percentage: CGFloat {
    case tenth = 0.1
    case fifth = 0.2
    case quarter = 0.25
    case third = 0.33
    case half = 0.5
    case full = 1.0
}

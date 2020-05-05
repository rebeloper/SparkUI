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

public enum STextFieldPlaceholderAnimation {
    case fade, slideUp
}

enum UIViewControllerModalPresentationStyle {
    case fill
    case sheet(topPadding: CGFloat = 80, topCornerRadius: CGFloat = 15)
    case intrinsic(topCornerRadius: CGFloat = 15)
    case constant(height: CGFloat, topCornerRadius: CGFloat = 15)
}

enum UIViewControllerSwipeToDismissStyle {
    case disabled
    case enabled
    case sticky
}

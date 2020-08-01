//
//  Console.swift
//
//
//  Created by Alex Nagy on 01/08/2020.
//

import UIKit

internal extension UIButton {
    func applyMiniStyle() {
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        tintColor = UIColor.systemBlue.withAlphaComponent(0.7)
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        layer.cornerRadius = 4
    }
}

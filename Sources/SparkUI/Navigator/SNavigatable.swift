//
//  SNavigatable.swift
//  
//
//  Created by Alex Nagy on 06/05/2020.
//

import Foundation
import UIKit

public typealias Navigatable = SNavigatable

public protocol SNavigatable: AnyObject {
    var childNavigators: [SNavigatable] { get set }
    var navigation: UINavigationController { get set }
    
    func start()
}

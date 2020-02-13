//
//  SViewController.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit
import Layoutless

open class SViewController: UIViewController {
    
    public let hud = SHud.create()
    
    public let container = UIView()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutViews()
        bind()
        observe()
    }
    
    open func layoutViews(relativeToSafeArea: Bool = true) {
        stack(.vertical)(
            container
            ).fillingParent(relativeToSafeArea: relativeToSafeArea).layout(in: view)
    }
    
    open func bind() {}
    
    open func observe() {}
}

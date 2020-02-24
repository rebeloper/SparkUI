//
//  SViewController.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit
import SparkExtensions

open class SViewController: UIViewController {
    
    public let hud = SHud.create()
    
    public let container = UIView()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        container.backgroundColor = .systemBackground
        layoutViews(safeArea: .all)
        bind()
        observe()
        continueViewDidLoad()
    }
    
    open func layoutViews(safeArea: SSafeArea) {
        view.addSubview(container)
        container.edgeTo(view, safeArea: safeArea)
    }
    
    open func bind() {}
    open func observe() {}
    open func continueViewDidLoad() {}
}

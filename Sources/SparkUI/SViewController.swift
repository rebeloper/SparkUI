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
        view.backgroundColor = .systemBackground
        viewDidLoadSetup()
        layoutViews()
        bind()
        observe()
    }
    
    open viewDidLoadSetup() {}
    
    open func layoutViews(safeArea: SSafeArea = .all) {
        view.addSubview(container)
        container.edgeTo(view, safeArea: safeArea)
    }
    
    open func bind() {}
    
    open func observe() {}
}

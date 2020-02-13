//
//  SViewController.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit
import Layoutless

class SViewController: UIViewController {
    
    public let container = UIView()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViewsWith(safeArea: .all)
        bind()
        observe()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open func setupViewsWith(safeArea: SSafeArea) {
        
    }
    
    open func bind() {}
    
    open func observe() {}
}

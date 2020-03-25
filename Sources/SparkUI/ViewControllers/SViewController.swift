//
//  SViewController.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit

open class SViewController: UIViewController {
    
    public var safeArea: SSafeArea
    
    public let hud = SHud.create()
    
    public let container = UIView()
    
    public init(safeArea: SSafeArea = .all) {
        self.safeArea = safeArea
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        container.backgroundColor = .systemBackground
        layoutViews()
        bind()
        observe()
        continueViewDidLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SHero.enable(in: self)
    }
    
    open func layoutViews() {
        view.addSubview(container)
        container.edgeTo(view, safeArea: safeArea)
    }
    
    open func bind() {}
    open func observe() {}
    open func continueViewDidLoad() {}
}

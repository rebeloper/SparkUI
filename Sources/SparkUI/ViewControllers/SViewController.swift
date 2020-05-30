//
//  SViewController.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit

open class SViewController: UIViewController {
    
    public var safeArea: SSafeArea
    
    public let container = UIView()
    
    public init(safeArea: SSafeArea = .all) {
        self.safeArea = safeArea
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError(SDebug.Message.FatalError.initCoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        container.backgroundColor = .systemBackground
        preLoad()
        configureNavigationBar()
        layoutViews()
        configureViews()
        addActions()
        subscribe()
        onLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
        onAppear()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disableHero()
        onDisappear()
    }
    
    
    open func preLoad() {}
    open func configureNavigationBar() {}
    
    open func layoutViews() {
        view.addSubview(container)
        container.edgeTo(view, safeArea: safeArea)
    }
    
    open func configureViews() {}
    open func addActions() {}
    open func subscribe() {}
    open func onLoad() {}
    
    open func onAppear() {}
    open func onDisappear() {}
}

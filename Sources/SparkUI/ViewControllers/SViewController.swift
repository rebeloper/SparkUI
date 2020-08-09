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
    
    fileprivate let injectionNotificationName = Notification.Name("INJECTION_BUNDLE_NOTIFICATION")
    
    public init(safeArea: SSafeArea = .all) {
        self.safeArea = safeArea
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError(SDebug.Message.FatalError.initCoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        load()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addInjectionNotification()
        enableHero()
        onAppear()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeInjectionNotification()
        disableHero()
        onDisappear()
    }
    
    fileprivate func addInjectionNotification() {
        #if DEBUG
        NotificationCenter.default.addObserver(self, selector: #selector(reloadInjection), name: injectionNotificationName, object: nil)
        #endif
    }
    
    fileprivate func removeInjectionNotification() {
        #if DEBUG
        NotificationCenter.default.removeObserver(self, name: injectionNotificationName, object: nil)
        #endif
    }
    
    @objc fileprivate func reloadInjection() {
        load()
    }
    
    fileprivate func setBackgroundColor() {
        view.backgroundColor = .systemBackground
        container.backgroundColor = .systemBackground
    }
    
    fileprivate func load() {
        preLoad()
        configureNavigationBar()
        layoutViews()
        configureViews()
        addActions()
        subscribe()
        onLoad()
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

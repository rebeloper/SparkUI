//
//  SWebViewController.swift
//  
//
//  Created by Alex Nagy on 07/05/2020.
//

import WebKit
import Layoutless

open class SWebViewController: SViewController {
    
    var navigatorActionType: NavigatorActionType?
    
    public init(url: String, safeArea: SSafeArea = .none, navigatorActionType: NavigatorActionType = .pushed) {
        self.navigatorActionType = navigatorActionType
        super.init(safeArea: safeArea)
        
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)

        title = "Loading..."
    }
    
    public required init?(coder: NSCoder) {
        fatalError(SDebug.Message.FatalError.initCoder)
    }
    
    public lazy var webView: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self
        view.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        view.addObserver(self, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        return view
    }()
    
    public lazy var cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel) {
        switch self.navigatorActionType {
        case .pushed:
            self.navigationController?.popViewController(animated: true)
        case .presented:
            self.dismiss(animated: true)
        case .none:
            print("SWebViewController: invalid navigatorActionType - none")
        }
        onDismissSWebViewController.value = true
    }
    
    public lazy var refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh) {
        self.webView.reload()
    }
    
    public lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        return progressView
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func onLoad() {
        super.onLoad()
        setupNavigation()
    }
    
    fileprivate func setupNavigation() {
        navigationItem.setLeftBarButton(cancelBarButtonItem, animated: false)
        navigationItem.setRightBarButton(refreshBarButtonItem, animated: false)
    }
    
    override open func layoutViews() {
        super.layoutViews()
        stack(.vertical)(
            progressView,
            webView
        ).fillingParent().layout(in: container)
    }
    
}

extension SWebViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}


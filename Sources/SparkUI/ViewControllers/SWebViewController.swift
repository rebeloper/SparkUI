//
//  SWebViewController.swift
//  
//
//  Created by Alex Nagy on 05/03/2020.
//

import WebKit
import ReactiveKit
import Bond
import Layoutless

open class SWebViewController: SViewController {
    
    public var url: String!
    
    public lazy var webView: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self
        view.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        view.addObserver(self, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        return view
    }()
    
    public lazy var cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil)
    
    public lazy var refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)
    
    public lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        return progressView
    }()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func continueViewDidLoad() {
        super.continueViewDidLoad()
        setupNavigation()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let url = URL(string: url) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
        title = "Loading..."
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
    
    override open func bind() {
        super.bind()
    }
    
    override open func observe() {
        super.observe()
        
        cancelBarButtonItem.reactive.tap.observeNext { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }.dispose(in: bag)
        
        refreshBarButtonItem.reactive.tap.observeNext { [weak self] in
            guard let self = self else { return }
            self.webView.reload()
        }.dispose(in: bag)
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

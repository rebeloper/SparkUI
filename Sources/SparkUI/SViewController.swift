//
//  SViewController.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit
import Layoutless

/// Spark ViewController with predifend, commonly used elements
public class SViewController: UIViewController {
    
    /// ViewController's container view to add any view onto it
    public let container = UIView()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layoutViews()
        bind()
        observe()
    }
    
    /// layout views onto the 'container'
    open func layoutViews(relativeToSafeArea: Bool = true) {
        stack(.vertical)(
            container
            ).fillingParent(relativeToSafeArea: relativeToSafeArea).layout(in: view)
    }
    
    /// bind your views here
    open func bind() {}
    
    /// observe your views here
    open func observe() {}
}

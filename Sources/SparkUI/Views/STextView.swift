//
//  STextView.swift
//  
//
//  Created by Alex Nagy on 14/05/2020.
//

import UIKit

public class STextView: SPlaceholderTextView {
    
    public var textBucket = Bucket("")
    
    public override init(frame: CGRect = .zero, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        NotificationCenter.default.addObserver(self, selector: #selector(STextView.applyTextViewTextDidChangeNotification(_:)), name: UITextView.textDidChangeNotification, object: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError(SDebug.Message.FatalError.initCoder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: self)
    }
    
    @objc internal func applyTextViewTextDidChangeNotification(_ notification: Notification) {
        guard let object = notification.object as? STextView, object === self else {
            return
        }
        textBucket.value = object.text
    }
    
}

public extension STextView {
    func onNext(interval: TimeInterval = 0.1, completion: @escaping (String) -> ()) {
        self.textBucket.onNext(throttle: interval, completion: completion)
    }
}

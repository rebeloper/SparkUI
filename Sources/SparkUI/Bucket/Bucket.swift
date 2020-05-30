//
//  Bucket.swift
//  
//
//  Created by Alex Nagy on 13/05/2020.
//

import UIKit
import Signals

/// 🧙‍♂️ Observable object that emits signals that can be subscribed to
public class Bucket<T> {
    
    private var shouldDebugWillSet: Bool = false
    private var shouldDebugDidSet: Bool = false
    
    /// 🧙‍♂️ The `Content` of the `Bucket` that creates a number of signals that can be subscribed to
    public let content = Signal<T>()
    
    ///  🧙‍♂️ Gets / Sets the latest value
    public var value: T {
        willSet(newValue) {
            if shouldDebugWillSet {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, HH:mm:ss:SSSZ"
                print(
                    """
                    -----------------------
                    🧙‍♂️ Bucket ~~> [\(Thread.isMainThread ? "" : "!")M] [\(dateFormatter.string(from: Foundation.Date()))]
                    \(self.value)
                    --- is going to be set as ---
                    \(newValue)
                    -----------------------
                    """
                )
            }
        }
        didSet(oldValue) {
            if shouldDebugDidSet {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, HH:mm:ss:SSSZ"
                print(
                    """
                    -----------------------
                    🧙‍♂️ Bucket ~~> [\(Thread.isMainThread ? "" : "!")M] [\(dateFormatter.string(from: Foundation.Date()))]
                    \(oldValue)
                    --- has been set to ---
                    \(self.value)
                    -----------------------
                    """
                )
            }
            self.content.fire(value)
        }
    }
    
    /// 🧙‍♂️ Initializes a `Bucket` with an initial value
    /// - Parameter initialValue: The initial value of the `Bucket`.
    public init(_ initialValue: T) {
        self.value = initialValue
    }
}

public extension Bucket {
    
    /// 🧙‍♂️ Debugs the `Bucket` in console
    func debug() -> Bucket {
        shouldDebugWillSet = true
        shouldDebugDidSet = true
        return self
    }
    
    /// 🧙‍♂️ Debugs `willSet` of the `Bucket` in console
    func debugWillSet() -> Bucket {
        shouldDebugWillSet = true
        return self
    }
    
    /// 🧙‍♂️ Debugs `didSet` of the `Bucket` in console
    func debugDidSet() -> Bucket {
        shouldDebugDidSet = true
        return self
    }
}

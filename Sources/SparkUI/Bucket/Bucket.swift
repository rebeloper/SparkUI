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
    
    private var shouldDebug: Bool = false
    
    /// 🧙‍♂️ The `Signal` of the `Bucket` that creates a number of signals that can be subscribed to
    public let value = Signal<T>()
    
    /// 🧙‍♂️ Gets the latest value of the `Bucket`
    public var getValue: T {
        didSet {
            if shouldDebug {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, HH:mm:ss:SSSZ"
                print("🧙‍♂️ Bucket ~~> [\(Thread.isMainThread ? "" : "!")M] [\(dateFormatter.string(from: Foundation.Date()))] ~~> did set value: \(getValue)")
            }
        }
    }
    
    /// 🧙‍♂️ Sets a new value into the Bucket
    /// - Parameter value: The new value of the `Bucket`.
    public func setValue(_ value: T) {
        self.getValue = value
        self.value.fire(value)
    }
    
    /// 🧙‍♂️ Initializes a `Bucket` with an initial value
    /// - Parameter initialValue: The initial value of the `Bucket`.
    public init(_ initialValue: T) {
        self.getValue = initialValue
        setValue(initialValue)
    }
}

public extension Bucket {
    
    /// 🧙‍♂️ Debugs the `Bucket` in console
    func /// 🧙‍♂️ Initializes a `Bucket` with an initial value() -> Bucket {
        shouldDebug = true
        return self
    }
}


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
    private let content = Signal<T>()
    
    ///  🧙‍♂️ Gets / Sets the latest value
    public var value: T {
        willSet(newValue) {
            if shouldDebugWillSet {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, HH:mm:ss:SSSZ"
                print(
                    """
                    -----------------------
                    🧙‍♂️ ~ \(Thread.isMainThread ? "🧵" : "🧶") Bucket ~~> [\(dateFormatter.string(from: Foundation.Date()))]
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
                    🧙‍♂️ ~ \(Thread.isMainThread ? "🧵" : "🧶") Bucket ~~> [\(dateFormatter.string(from: Foundation.Date()))]
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

public extension Bucket {
    
    /// 🧙‍♂️ Safely subscribes an observer to the `Bucket`.
    ///
    /// - parameter observer: The observer that subscribes to the `Bucket`. Should the observer be deallocated, the subscription is automatically cancelled.
    /// - parameter callback: The closure to invoke whenever the `Bucket` fires.
    /// - returns: A `SignalSubscription` that can be used to cancel or filter the subscription.
    @discardableResult
    func subscribe(with observer: AnyObject, callback: @escaping (T) -> Void) -> SignalSubscription<T> {
        content.cancelSubscription(for: observer)
        return content.subscribe(with: observer, callback: callback)
    }
    
    /// 🧙‍♂️ Safely subscribes an observer to the `Bucket`. The subscription is automatically canceled after the `Bucket` has fired once.
    ///
    /// - parameter observer: The observer that subscribes to the `Bucket`. Should the observer be deallocated, the subscription is automatically cancelled.
    /// - parameter callback: The closure to invoke when the signal fires for the first time.
    /// - returns: A `SignalSubscription` that can be used to cancel or filter the subscription.
    @discardableResult
    func subscribeOnce(with observer: AnyObject, callback: @escaping (T) -> Void) -> SignalSubscription<T> {
        content.cancelSubscription(for: observer)
        return content.subscribeOnce(with: observer, callback: callback)
    }
    
    /// 🧙‍♂️ Safely subscribes an observer forever to the `Bucket`.
    /// Needs a new `Permanent` on every subscription
    ///
    /// - parameter permanent: The permanent observer that subscribes to the `Bucket`. The permanent observer will never be deallocated, the subscription will never be cancelled.
    /// - parameter callback: The closure to invoke whenever the `Bucket` fires.
    /// - returns: A `SignalSubscription` that can be used to cancel or filter the subscription.
    @discardableResult
    func subscribeForever(with permanent: Permanent, callback: @escaping (T) -> Void) -> SignalSubscription<T> {
        subscribe(with: permanent, callback: callback)
    }
    
}

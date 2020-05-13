//
//  Bucket.swift
//  
//
//  Created by Alex Nagy on 13/05/2020.
//

import UIKit
import Combine

public class Bucket<Value> {
    private var cancelableValue: AnyCancellable?
    private var cancelableAssign: AnyCancellable?
    @Published public var value: Value?
    
    public init(_ first: Value?) {
        self.value = first
    }
    
    public init() {}
    
    deinit {
        cancelableValue?.cancel()
        cancelableAssign?.cancel()
    }
    
    public func onNextWithFirst(completion: @escaping (Value?)->()) {
        cancelableValue = $value
            .sink { (value) in
                completion(value)
        }
    }
    
    public func onNextWithFirst(throttle: TimeInterval, completion: @escaping (Value?)->()) {
        cancelableValue = $value
            .throttle(for: RunLoop.SchedulerTimeType.Stride(throttle), scheduler: RunLoop.main, latest: false)
            .sink { (value) in
                completion(value)
        }
    }
    
    public func onNext(dropFirst count: Int, completion: @escaping (Value?)->()) {
        cancelableValue = $value
            .dropFirst(count)
            .sink { (value) in
                completion(value)
        }
    }
    
    public func onNext(throttle: TimeInterval, completion: @escaping (Value?)->()) {
        cancelableValue = $value
            .dropFirst()
            .throttle(for: RunLoop.SchedulerTimeType.Stride(throttle), scheduler: RunLoop.main, latest: false)
            .sink { (value) in
                completion(value)
        }
    }
    
    public func onNext(dropFirst count: Int, throttle: TimeInterval, completion: @escaping (Value?)->()) {
        cancelableValue = $value
            .dropFirst(count)
            .throttle(for: RunLoop.SchedulerTimeType.Stride(throttle), scheduler: RunLoop.main, latest: false)
            .sink { (value) in
                completion(value)
        }
    }
    
    public func onNext(completion: @escaping (Value?)->()) {
        cancelableValue = $value
            .dropFirst()
            .sink { (value) in
                completion(value)
        }
    }
    
    public func assign<Root>(to: ReferenceWritableKeyPath<Root, Value?>, on: Root) {
        cancelableAssign = $value.assign(to: to, on: on)
    }
    
}



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
    @Published public var value: Value
    public var get: Value
    
    public init(_ first: Value) {
        self.value = first
        self.get = first
    }
    
    deinit {
        cancelableValue?.cancel()
    }
    
}

public extension Bucket {
    
    func onNextWithFirst(completion: @escaping (Value)->()) {
        cancelableValue = $value
            .sink { (value) in
                self.get = value
                completion(value)
        }
    }
    
    func onNextWithFirst(throttle: TimeInterval, completion: @escaping (Value)->()) {
        cancelableValue = $value
            .throttle(for: RunLoop.SchedulerTimeType.Stride(throttle), scheduler: RunLoop.main, latest: false)
            .sink { (value) in
                self.get = value
                completion(value)
        }
    }
    
    func onNext(dropFirst count: Int, completion: @escaping (Value)->()) {
        cancelableValue = $value
            .dropFirst(count)
            .sink { (value) in
                self.get = value
                completion(value)
        }
    }
    
    func onNext(throttle: TimeInterval, completion: @escaping (Value)->()) {
        cancelableValue = $value
            .dropFirst()
            .throttle(for: RunLoop.SchedulerTimeType.Stride(throttle), scheduler: RunLoop.main, latest: false)
            .sink { (value) in
                self.get = value
                completion(value)
        }
    }
    
    func onNext(dropFirst count: Int, throttle: TimeInterval, completion: @escaping (Value)->()) {
        cancelableValue = $value
            .dropFirst(count)
            .throttle(for: RunLoop.SchedulerTimeType.Stride(throttle), scheduler: RunLoop.main, latest: false)
            .sink { (value) in
                self.get = value
                completion(value)
        }
    }
    
    func onNext(completion: @escaping (Value)->()) {
        cancelableValue = $value
            .dropFirst()
            .sink { (value) in
                self.get = value
                completion(value)
        }
    }
    
}



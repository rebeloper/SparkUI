//
//  AssignableBucket.swift
//  
//
//  Created by Alex Nagy on 14/05/2020.
//

import UIKit
import Combine

public class AssignableBucket<Value> {
    private var cancelableValue: AnyCancellable?
    private var cancelableAssign: AnyCancellable?
    @Published public var value: Value?  {
           didSet {
               get = value
           }
       }
    public var get: Value?
    
    public init(_ first: Value?) {
        self.value = first
        self.get = first
    }
    
    public init() {}
    
    deinit {
        cancelableValue?.cancel()
        cancelableAssign?.cancel()
    }
    
}

public extension AssignableBucket {
    
    func onNextWithFirst(completion: @escaping (Value?)->()) {
        cancelableValue = $value
            .sink { (value) in
                self.get = value
                completion(value)
        }
    }
    
    func onNextWithFirst(throttle: TimeInterval, completion: @escaping (Value?)->()) {
        cancelableValue = $value
            .throttle(for: RunLoop.SchedulerTimeType.Stride(throttle), scheduler: RunLoop.main, latest: false)
            .sink { (value) in
                self.get = value
                completion(value)
        }
    }
    
    func onNext(dropFirst count: Int, completion: @escaping (Value?)->()) {
        cancelableValue = $value
            .dropFirst(count)
            .sink { (value) in
                self.get = value
                completion(value)
        }
    }
    
    func onNext(throttle: TimeInterval, completion: @escaping (Value?)->()) {
        cancelableValue = $value
            .dropFirst()
            .throttle(for: RunLoop.SchedulerTimeType.Stride(throttle), scheduler: RunLoop.main, latest: false)
            .sink { (value) in
                self.get = value
                completion(value)
        }
    }
    
    func onNext(dropFirst count: Int, throttle: TimeInterval, completion: @escaping (Value?)->()) {
        cancelableValue = $value
            .dropFirst(count)
            .throttle(for: RunLoop.SchedulerTimeType.Stride(throttle), scheduler: RunLoop.main, latest: false)
            .sink { (value) in
                self.get = value
                completion(value)
        }
    }
    
    func onNext(completion: @escaping (Value?)->()) {
        cancelableValue = $value
            .dropFirst()
            .sink { (value) in
                self.get = value
                completion(value)
        }
    }
    
}

public extension AssignableBucket {
    
    func assign<Root>(to: ReferenceWritableKeyPath<Root, Value?>, on: Root) {
        cancelableAssign = $value.assign(to: to, on: on)
    }
    
}




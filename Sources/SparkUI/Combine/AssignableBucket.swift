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
    @Published public var setValue: Value?
    public var getValue: Value?
    
    public init(_ first: Value?) {
        self.setValue = first
        self.getValue = first
    }
    
    public init() {}
    
    deinit {
        cancelableValue?.cancel()
        cancelableAssign?.cancel()
    }
    
}

public extension AssignableBucket {
    
    func onNextWithFirst(completion: @escaping (Value?)->()) {
        cancelableValue = $setValue
            .sink { (value) in
                self.getValue = value
                completion(value)
        }
    }
    
    func onNextWithFirst(throttle: TimeInterval, completion: @escaping (Value?)->()) {
        cancelableValue = $setValue
            .throttle(for: RunLoop.SchedulerTimeType.Stride(throttle), scheduler: RunLoop.main, latest: false)
            .sink { (value) in
                self.getValue = value
                completion(value)
        }
    }
    
    func onNext(dropFirst count: Int, completion: @escaping (Value?)->()) {
        cancelableValue = $setValue
            .dropFirst(count)
            .sink { (value) in
                self.getValue = value
                completion(value)
        }
    }
    
    func onNext(throttle: TimeInterval, completion: @escaping (Value?)->()) {
        cancelableValue = $setValue
            .dropFirst()
            .throttle(for: RunLoop.SchedulerTimeType.Stride(throttle), scheduler: RunLoop.main, latest: false)
            .sink { (value) in
                self.getValue = value
                completion(value)
        }
    }
    
    func onNext(dropFirst count: Int, throttle: TimeInterval, completion: @escaping (Value?)->()) {
        cancelableValue = $setValue
            .dropFirst(count)
            .throttle(for: RunLoop.SchedulerTimeType.Stride(throttle), scheduler: RunLoop.main, latest: false)
            .sink { (value) in
                self.getValue = value
                completion(value)
        }
    }
    
    func onNext(completion: @escaping (Value?)->()) {
        cancelableValue = $setValue
            .dropFirst()
            .sink { (value) in
                self.getValue = value
                completion(value)
        }
    }
    
}

public extension AssignableBucket {
    
    func assign<Root>(to: ReferenceWritableKeyPath<Root, Value?>, on: Root) {
        cancelableAssign = $setValue.assign(to: to, on: on)
    }
    
}




//
//  Int+.swift
//  
//
//  Created by Alex Nagy on 08/03/2020.
//

import Foundation

public extension Int {
    func toTimeString(allowedUnits: NSCalendar.Unit = [.hour, .minute, .second]) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = allowedUnits
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(self))!
    }
    
    func toStripeAmount() -> Int {
        self * 100
    }
    
    func fromStripeAmount() -> Int {
        self / 100
    }
    
    mutating func increment(_ amount: Int = 1) {
        self += amount
    }
    
    mutating func decrement(_ amount: Int = 1) {
        self -= amount
    }
    
    mutating func makeZero() {
        self = 0
    }
    
    static var zero = Int(0)
    static var empty = Int()
}

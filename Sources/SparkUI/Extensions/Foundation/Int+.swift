//
//  Int+.swift
//  
//
//  Created by Alex Nagy on 08/03/2020.
//

import Foundation

extension Int {
    public func toTimeString(allowedUnits: NSCalendar.Unit = [.hour, .minute, .second]) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = allowedUnits
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(self))!
    }
}

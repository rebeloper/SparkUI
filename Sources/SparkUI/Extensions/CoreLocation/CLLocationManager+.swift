//
//  CLLocationManager+.swift
//  
//
//  Created by Alex Nagy on 22/05/2020.
//

import CoreLocation

public extension CLLocationManager {
    
    @discardableResult
    func delegate(_ delegate: CLLocationManagerDelegate) -> CLLocationManager {
        self.delegate = delegate
        return self
    }
    
    @discardableResult
    func activityType(_ activityType: CLActivityType) -> CLLocationManager {
        self.activityType = activityType
        return self
    }
    
    @discardableResult
    func desiredAccuracy(_ desiredAccuracy: CLLocationAccuracy) -> CLLocationManager {
        self.desiredAccuracy = desiredAccuracy
        return self
    }
    
}

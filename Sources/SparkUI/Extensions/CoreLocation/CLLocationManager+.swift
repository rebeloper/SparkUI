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
        if CLLocationManager.locationServicesEnabled() {
            self.delegate = delegate
        } else {
            Alert.showError(message: "Location Service disabled")
        }
        return self
    }
    
    @discardableResult
    func activityType(_ activityType: CLActivityType) -> CLLocationManager {
        if CLLocationManager.locationServicesEnabled() {
            self.activityType = activityType
        }
        return self
    }
    
    @discardableResult
    func desiredAccuracy(_ desiredAccuracy: CLLocationAccuracy) -> CLLocationManager {
        if CLLocationManager.locationServicesEnabled() {
            self.desiredAccuracy = desiredAccuracy
        }
        return self
    }
    
}

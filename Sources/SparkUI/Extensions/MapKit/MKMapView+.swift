//
//  MKMapView+.swift
//  
//
//  Created by Alex Nagy on 02/07/2020.
//

import MapKit

public extension MKMapView {
    
    func zoomIn(coordinate: CLLocationCoordinate2D, withLevel level:CLLocationDistance = 10000, animated: Bool = true){
        let camera =
            MKMapCamera(lookingAtCenter: coordinate, fromEyeCoordinate: coordinate, eyeAltitude: level)
        self.setCamera(camera, animated: animated)
    }
}

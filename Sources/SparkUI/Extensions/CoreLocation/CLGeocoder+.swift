//
//  CLGeocoder+.swift
//  
//
//  Created by Alex Nagy on 22/05/2020.
//

import CoreLocation

public extension CLGeocoder {
    
    func getPlacemark(for location: CLLocation, completion: @escaping (Result<CLPlacemark?, Error>) -> ()) {
        self.reverseGeocodeLocation(location) { placemarks, err in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            guard let placemark = placemarks?[0] else {
                completion(.success(nil))
                return
            }
            
            completion(.success(placemark))
        }
    }
    
    func getLocation(forPlaceNamed name: String, completion: @escaping (Result<CLLocation?, Error>) -> ()) {
        self.geocodeAddressString(name) { placemarks, err in
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            guard let placemark = placemarks?[0] else {
                completion(.success(nil))
                return
            }
            
            guard let location = placemark.location else {
                completion(.success(nil))
                return
            }
            
            completion(.success(location))
        }
    }
}


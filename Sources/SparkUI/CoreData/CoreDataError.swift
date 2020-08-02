//
//  File.swift
//  
//
//  Created by Alex Nagy on 02/08/2020.
//

import Foundation

struct CoreDataError {
    static let noFetchRequest = NSError(domain: "No Fetch Request", code: 1, userInfo: nil)
    static let noFinalResult = NSError(domain: "No Final Result", code: 1, userInfo: nil)
}

//
//  SDocumentSerializable.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import Foundation

public protocol SDocumentSerializable {
    init?(from documentData: [String: Any])
}

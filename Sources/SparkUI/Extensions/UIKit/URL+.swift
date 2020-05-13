//
//  URL+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit

public extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}

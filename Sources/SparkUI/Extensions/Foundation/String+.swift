//
//  String+.swift
//  
//
//  Created by Alex Nagy on 30/05/2020.
//

import Foundation

public extension String {
    static var empty = String()
    
    mutating func makeEmpty() {
        self = ""
    }
}

public extension String {
    func getFirstAndLastName() -> (String, String)? {
        var components = self.components(separatedBy: " ")
        if components.count > 0 {
            let firstName = components.removeFirst()
            let lastName = components.joined(separator: " ")
            return (firstName, lastName)
        }
        return nil
    }
}

public extension String {
    
    enum ValidityType {
        case age
        case email
        case password
        case website(extension: String = "", subpages: Bool = false)
    }
    
    enum Regex: String {
        case age = "[0-9]{2,2}"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case password = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,25}"
        case website = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?" // any site url
//        case websiteComOrgWithSubpages = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.(org|com)(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?" // any site url with .com or .org and subpages
//        case websiteComOrgNoSubpages = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.(org|com)" // any site url with .com or .org and NO subpages
//        case websiteOrgNoSubpages = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.org" // any site url with only .org and NO subpages
    }
    
    func isValid(_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validityType {
        case .age:
            regex = Regex.age.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        case .website(let ext, let subpages):
            regex = Regex.website.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
    
}


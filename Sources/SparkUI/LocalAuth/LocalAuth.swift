//
//  LocalAuth.swift
//  
//
//  Created by Alex Nagy on 30/08/2020.
//

import LocalAuthentication

public struct LocalAuth {
    
    public static func authenticate(policy: LAPolicy = .deviceOwnerAuthentication, touchIdLocalizedReason: String,  completion: @escaping ((Bool) -> ())){
        
        let authenticationContext = LAContext()
        var error: NSError?
        
        let isValidSensor : Bool = authenticationContext.canEvaluatePolicy(policy, error: &error)
        
        if isValidSensor {
            authenticationContext.evaluatePolicy(policy, localizedReason: touchIdLocalizedReason) { (success, err) in
                if success {
                    completion(true)
                } else {
                    if let err = err {
                        let message = errorMessage(errorCode: err._code)
                        if message != "" {
                            Alert.showError(message: message)
                        }
                    }
                    completion(false)
                }
            }
        } else {
            let message = errorMessage(errorCode: (error?._code)!)
            if message != "" {
                Alert.showError(message: message)
            }
        }
        
    }
    
    static func errorMessage(errorCode:Int) -> String{
        
        var strMessage = ""
        
        switch errorCode {
            
        case LAError.Code.authenticationFailed.rawValue:
            strMessage = "Authentication Failed"
            
        case LAError.Code.userCancel.rawValue:
            strMessage = "User Cancel"
            
        case LAError.Code.systemCancel.rawValue:
            strMessage = "System Cancel"
            
        case LAError.Code.passcodeNotSet.rawValue:
            strMessage = "Please go to Settings & Turn On Passcode"
            
        case LAError.Code.biometryNotAvailable.rawValue:
            strMessage = "TouchID or FaceID Not Available"
            
        case LAError.Code.biometryNotEnrolled.rawValue:
            strMessage = "TouchID or FaceID Not Enrolled"
            
        case LAError.Code.biometryLockout.rawValue:
            strMessage = "TouchID or FaceID Lockout. Please go to Settings & Turn On Passcode"
            
        case LAError.Code.appCancel.rawValue:
            strMessage = "App Cancel"
            
        case LAError.Code.invalidContext.rawValue:
            strMessage = "Invalid Context"
            
        default:
            strMessage = ""
            
        }
        return strMessage
    }
}

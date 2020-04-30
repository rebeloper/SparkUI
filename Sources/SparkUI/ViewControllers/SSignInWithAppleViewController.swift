//
//  SSignInWithAppleViewController.swift
//  
//
//  Created by Alex Nagy on 09/03/2020.
//

import UIKit
import ReactiveKit
import AuthenticationServices
import CryptoKit

public struct SSignInWithAppleObserver {
    public let name: String
    public let nonce: String
    public let idTokenString: String
}

public struct SSignInWithAppleErrorObserver {
    let error: Error
}

open class SSignInWithAppleViewController: SViewController {
    
    // MARK: - Provider ID
    
    public let providerIDForSignInWithApple = "apple.com"
    
    // MARK: - Default observers
    
    public let defaultSignInWithAppleObserver = SSignInWithAppleObserver(name: "", nonce: "", idTokenString: "")
    public let defaultSignInWithAppleErrorObserver = SSignInWithAppleErrorObserver(error: NSError())
    
    // MARK: - Properties
    
    public var currentNonce: String? // Unhashed nonce.
    
    // MARK: - Observers
    
    public lazy var signInWithAppleObserver = Property(defaultSignInWithAppleObserver)
    public lazy var signInWithAppleErrorObserver = Property(defaultSignInWithAppleErrorObserver)
    
    // MARK: - Views
    public var signInWithAppleButton: ASAuthorizationAppleIDButton!
    
    @objc public func didTapSignInWithAppleButton() {
        #if !targetEnvironment(simulator)
        Hud.show(title: "Working", message: "Signing In with Apple...")
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        #endif
    }
    
    public init(safeArea: SSafeArea = .all, authorizationButtonType: ASAuthorizationAppleIDButton.ButtonType = .continue, authorizationButtonStyle: ASAuthorizationAppleIDButton.Style = .whiteOutline) {
        self.signInWithAppleButton = ASAuthorizationAppleIDButton(authorizationButtonType: authorizationButtonType, authorizationButtonStyle: authorizationButtonStyle)
        super.init(safeArea: safeArea)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        signInWithAppleButton.addTarget(self, action: #selector(didTapSignInWithAppleButton), for: .touchUpInside)
    }
    
    override open func continueViewDidLoad() {
        super.continueViewDidLoad()
    }
    
    // MARK: - Layout
    
    override open func layoutViews() {
        super.layoutViews()
    }
    
    // MARK: - Bind
    
    override open func bind() {
        super.bind()
    }
    
    // MARK: - Observe
    
    override open func observe() {
        super.observe()
    }
    
}

extension SSignInWithAppleViewController {
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    public func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if length == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    @available(iOS 13, *)
    public func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

extension SSignInWithAppleViewController {
    public func getName(from appleIDCredential: ASAuthorizationAppleIDCredential) -> String {
        var name = ""
        let fullName = appleIDCredential.fullName
        let givenName = fullName?.givenName ?? ""
        let middleName = fullName?.middleName ?? ""
        let familyName = fullName?.familyName ?? ""
        let names = [givenName, middleName, familyName]
        let filteredNames = names.filter {$0 != ""}
        for i in 0..<filteredNames.count {
            name += filteredNames[i]
            if i != filteredNames.count - 1 {
                name += " "
            }
        }
        return name
    }
}

extension SSignInWithAppleViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        let vc = UIApplication.shared.windows.last?.rootViewController
        return (vc?.view.window!)!
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                let errMessage = "Unable to fetch identity token"
                Hud.hideWithErrorAlert(message: errMessage)
                let err = NSError(domain: errMessage, code: 4, userInfo: nil)
                self.signInWithAppleErrorObserver.value = SSignInWithAppleErrorObserver(error: err)
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                let errMessage = "Unable to serialize token string from data"
                Hud.hideWithErrorAlert(message: errMessage)
                let err = NSError(domain: errMessage, code: 4, userInfo: nil)
                self.signInWithAppleErrorObserver.value = SSignInWithAppleErrorObserver(error: err)
                return
            }
            
            self.signInWithAppleObserver.value = SSignInWithAppleObserver(name: getName(from: appleIDCredential), nonce: nonce, idTokenString: idTokenString)
            Hud.hide()
            
        } else {
            Hud.hideWithErrorAlert(message: "No Apple ID Credential found")
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.signInWithAppleErrorObserver.value = SSignInWithAppleErrorObserver(error: error)
        Hud.hideWithErrorAlert(message: error.localizedDescription)
    }
    
}

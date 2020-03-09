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
    public let nonce: String
    public let appleIDToken: Data
    public let idTokenString: String
}

public struct SSignInWithAppleErrorObserver {
    let error: Error
}

open class SSignInWithAppleViewController: SViewController {
    
    // MARK: - Default observers
    
    public let defaultSignInWithApple = SSignInWithAppleObserver(nonce: "", appleIDToken: Data(), idTokenString: "")
    public let defaultSignInWithAppleError = SSignInWithAppleErrorObserver(error: NSError())
    
    // MARK: - Properties
    
    public var currentNonce: String? // Unhashed nonce.
    
    // MARK: - Observers
    
    public lazy var signInWithAppleObserver = Property(defaultSignInWithApple)
    public lazy var signInWithAppleErrorObserver = Property(defaultSignInWithAppleError)
    
    // MARK: - Views
    public var signInWithAppleButton: ASAuthorizationAppleIDButton!
    
    @objc public func didTapSignInWithAppleButton() {
        #if !targetEnvironment(simulator)
        SHud.handle(self.hud, with: SHudInfo(type: .show, text: "Working", detailText: "Signing in with Apple..."))
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
    
    public init(authorizationButtonType: ASAuthorizationAppleIDButton.ButtonType = .continue, authorizationButtonStyle: ASAuthorizationAppleIDButton.Style = .whiteOutline) {
        self.signInWithAppleButton = ASAuthorizationAppleIDButton(authorizationButtonType: authorizationButtonType, authorizationButtonStyle: authorizationButtonStyle)
        super.init(safeArea: .all)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
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
                SHud.handle(self.hud, with: SHudInfo(type: .closeWithErrorAlert, text: "", detailText: "Unable to fetch identity token"))
                let err = NSError(domain: "Unable to fetch identity token", code: 4, userInfo: nil)
                self.signInWithAppleErrorObserver.value = SSignInWithAppleErrorObserver(error: err)
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                SHud.handle(self.hud, with: SHudInfo(type: .closeWithErrorAlert, text: "", detailText: "Unable to serialize token string from data"))
                let err = NSError(domain: "Unable to serialize token string from data", code: 4, userInfo: nil)
                self.signInWithAppleErrorObserver.value = SSignInWithAppleErrorObserver(error: err)
                return
            }
            
            self.signInWithAppleObserver.value = SSignInWithAppleObserver(nonce: nonce, appleIDToken: appleIDToken, idTokenString: idTokenString)
            SHud.handle(self.hud, with: SHudInfo(type: .close))
            
        } else {
            SHud.handle(self.hud, with: SHudInfo(type: .closeWithErrorAlert, text: "", detailText: "No Apple ID Credential found"))
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.signInWithAppleErrorObserver.value = SSignInWithAppleErrorObserver(error: error)
        SHud.handle(self.hud, with: SHudInfo(type: .closeWithErrorAlert, text: "", detailText: error.localizedDescription))
    }
    
}

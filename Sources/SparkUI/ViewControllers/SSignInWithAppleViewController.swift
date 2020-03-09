//
//  SSignInWithAppleViewController.swift
//  
//
//  Created by Alex Nagy on 09/03/2020.
//

import UIKit
import AuthenticationServices

public class SSignInWithAppleViewController: SViewController {
    
    // MARK: - Dependencies
    
    // MARK: - Delegates
    
    // MARK: - Properties
    
    // Unhashed nonce.
    var currentNonce: String?
    
    // MARK: - Views
    var signInWithAppleButton: ASAuthorizationAppleIDButton?
    
    @objc func didTapSignInWithAppleButton() {
        #if !targetEnvironment(simulator)
        SHud.handle(self.hud, with: SHudInfo(type: .show, text: "Working", detailText: "Signing in with Apple..."))
        let nonce = SparkAuth.randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = SparkAuth.sha256(nonce)
        
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
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                SHud.handle(self.hud, with: SHudInfo(type: .closeWithErrorAlert, text: "", detailText: "Unable to serialize token string from data"))
                return
            }
            
//            SparkAuth.signIn(providerID: SparkAuthProviderID.apple, idTokenString: idTokenString, nonce: nonce) { (result) in
//                SHud.handle(self.hud, with: SHudInfo(type: .close))
//                switch result {
//                case .success(let authDataResult):
//                    let email = authDataResult.user.email ?? ""
//                    let profile = Profile(uid: authDataResult.user.uid,
//                                          state: ProfileState.created,
//                                          typeUsed: SparkProperty.profileTypeUsed.value.rawValue,
//                                          name: self.getName(from: appleIDCredential),
//                                          email: email,
//                                          profileImageUrl: "",
//                                          headerImageUrl: "",
//                                          ownerUids: [],
//                                          clientUids: [],
//                                          invitationUrl: "",
//                                          isStripeConnectAuthorized: false)
//                    SparkProperty.profile.value = profile
//                    // let configureFirebaseStateDidChange take care of saving the profile to Firestore / updating the profile in Firestore if necessary
//
//                case .failure(let err):
//                    SHud.handle(self.hud, with: SHudInfo(type: .closeWithErrorAlert, text: "", detailText: err.localizedDescription))
//                }
//            }
            
        } else {
            SHud.handle(self.hud, with: SHudInfo(type: .closeWithErrorAlert, text: "", detailText: "No Apple ID Credential found"))
        }
    }
    
    fileprivate func getName(from appleIDCredential: ASAuthorizationAppleIDCredential) -> String {
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
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        SHud.handle(self.hud, with: SHudInfo(type: .closeWithErrorAlert, text: "", detailText: error.localizedDescription))
    }
    
}

//
//  SMailComposeViewController.swift
//  
//
//  Created by Alex Nagy on 09/03/2020.
//

import MessageUI

open class SMailComposeViewController: MFMailComposeViewController {
    
    public init(recipients: [String]?, subject: String = "", messageBody: String = "", messageBodyIsHTML: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        setToRecipients(recipients)
        setSubject(subject)
        setMessageBody(messageBody, isHTML: messageBodyIsHTML)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



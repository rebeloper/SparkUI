//
//  SMailComposeViewController.swift
//  
//
//  Created by Alex Nagy on 09/03/2020.
//

import MessageUI

public class SMailComposeViewController: MFMailComposeViewController {
    
    public var recipients: [String]?
    public var subject: String
    public var messageBody: String
    public var messageBodyIsHTML: Bool
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setToRecipients(recipients)
        setSubject(subject)
        setMessageBody(messageBody, isHTML: messageBodyIsHTML)
    }
    
    public init(recipients: [String]?, subject: String = "", messageBody: String = "", messageBodyIsHTML: Bool = true) {
        self.recipients = recipients
        self.subject = subject
        self.messageBody = messageBody
        self.messageBodyIsHTML = messageBodyIsHTML
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



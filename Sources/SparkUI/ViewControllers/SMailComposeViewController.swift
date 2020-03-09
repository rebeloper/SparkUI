//
//  SMailComposeViewController.swift
//  
//
//  Created by Alex Nagy on 09/03/2020.
//

import MessageUI

class SMailComposeViewController: MFMailComposeViewController {
    
    var recipients: [String]?
    var subject: String
    var messageBody: String
    var messageBodyIsHTML: Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setToRecipients(recipients)
        setSubject(subject)
        setMessageBody(messageBody, isHTML: messageBodyIsHTML)
    }
    
    init(recipients: [String]?, subject: String = "", messageBody: String = "", messageBodyIsHTML: Bool = true) {
        self.recipients = recipients
        self.subject = subject
        self.messageBody = messageBody
        self.messageBodyIsHTML = messageBodyIsHTML
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



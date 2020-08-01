//
//  Console.swift
//
//
//  Created by Alex Nagy on 01/08/2020.
//

import UIKit
import MessageUI

/// This UIViewController
class ConsoleViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 4
        return stackView
    }()
    private let stackViewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        return view
    }()
    
    private let consoleTextView = UITextView.console
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        Console.shared.textView = consoleTextView
        view.addSubview(consoleTextView)
        view.addSubview(stackViewBackground)
        view.addSubview(stackView)
        setupConstraints()
        
        let customTextButton = UIButton(type: .system)
        customTextButton.setTitle("Text", for: .normal)
        customTextButton.addTarget(self, action: #selector(customText(sender:)), for: .touchUpInside)
        customTextButton.applyMiniStyle()
        stackView.addArrangedSubview(customTextButton)
        
        let lineButton = UIButton(type: .system)
        lineButton.setTitle("Line", for: .normal)
        lineButton.addTarget(self, action: #selector(addLine(sender:)), for: .touchUpInside)
        lineButton.applyMiniStyle()
        stackView.addArrangedSubview(lineButton)
        
        let setHeightButton = UIButton(type: .system)
        setHeightButton.setTitle("Height", for: .normal)
        setHeightButton.addTarget(self, action: #selector(setHeight(sender:)), for: .touchUpInside)
        setHeightButton.applyMiniStyle()
        stackView.addArrangedSubview(setHeightButton)
        
        let clearButton = UIButton(type: .system)
        clearButton.setTitle("Clear", for: .normal)
        clearButton.addTarget(self, action: #selector(clearConsole(sender:)), for: .touchUpInside)
        clearButton.applyMiniStyle()
        stackView.addArrangedSubview(clearButton)
        
        let mailButton = UIButton(type: .system)
        mailButton.setTitle("Mail", for: .normal)
        mailButton.addTarget(self, action: #selector(sendMail(sender:)), for: .touchUpInside)
        mailButton.applyMiniStyle()
        stackView.addArrangedSubview(mailButton)
    }

    private func setupConstraints() {
        consoleTextView.translatesAutoresizingMaskIntoConstraints = false
        consoleTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 42).isActive = true
        consoleTextView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        view.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: consoleTextView.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: consoleTextView.bottomAnchor).isActive = true
        
        stackViewBackground.translatesAutoresizingMaskIntoConstraints = false
        stackViewBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackViewBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stackViewBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stackViewBackground.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 4).isActive = true
        view.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: -8).isActive = true
    }

    @objc func customText(sender: AnyObject) {
        let alert = UIAlertController(title: "Custom Log", message: "Enter text you want to log.", preferredStyle: .alert)
        alert.addTextField { $0.keyboardType = .default }
        alert.addAction(.okAddLog(with: alert))
        alert.addAction(.cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func setHeight(sender: AnyObject) {
        let alert = UIAlertController(title: "Height", message: "Enter console height", preferredStyle: .alert)
        alert.addTextField {
            $0.keyboardType = .numberPad
            $0.placeholder = "Set height greater than \(Console.consoleHeight)"
        }
        alert.addAction(.okSetHeight(with: alert))
        alert.addAction(.cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func clearConsole(sender: AnyObject) {
        Console.clear()
    }
    
    internal func getStringValue(forKey: String) -> String {
        guard let value = Bundle.main.infoDictionary?[forKey] as? String else {
            fatalError("No value found for key '\(forKey)' in the Info.plist file")
        }
        return value
    }
    
    internal func getBundleId() -> String {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            fatalError("could not find bundle id in the Info.plist file")
        }
        return bundleId
    }
    
    @objc func sendMail(sender: AnyObject) {
        DispatchQueue.main.async {
            guard let text = Console.shared.textView?.text, text != "" else {
                let alert = UIAlertController(title: "Info", message: "Console is empty", preferredStyle: .alert)
                alert.addAction(.ok())
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            if MFMailComposeViewController.canSendMail() {
                let composeViewController = MFMailComposeViewController()
                composeViewController.mailComposeDelegate = self
                if let supportEmail = Console.supportEmail {
                    composeViewController.setToRecipients([supportEmail])
                }
                let subject = "Console Log for \(self.getStringValue(forKey: "CFBundleName")) - \(self.getStringValue(forKey: "CFBundleShortVersionString")) (\(self.getStringValue(forKey: "CFBundleVersion")))"
                composeViewController.setSubject(subject)
                
                let body = """
                ---------- ISSUE ----------
                Describe your issue.
                
                
                ---------- HISTORY ----------
                What did you do that led up to this issue?
                
                ---------- SCREEN RECORDING ----------
                Please attach a screen recording presenting the issue.
                Important: You must record your screen before you initialize this email so you may attach it from the 'Screen Recordings' folder.
                
                You can insert videos with these five easy steps:
                1). long press the screen anywhere in this email (preferably where it says 'Recording:' below)
                2). tap on ▶
                3). tap 'Insert Photo or Video'
                4). tap 'All Photos'
                5). select the latest video from 'Screen Recordings'
                
                Recording:

                ---------- NOTES ----------
                Anything else that you would like to add?
                
                
                
                ---------- CONSOLE LOG START ----------
                \(text)
                ---------- CONSOLE LOG END ----------
                
                ---------- PROJECT DETAILS ----------
                Bundle dispaly name: \(self.getStringValue(forKey: "CFBundleName"))
                Bundle id: \(self.getBundleId())
                Version: \(self.getStringValue(forKey: "CFBundleShortVersionString"))
                Build: \(self.getStringValue(forKey: "CFBundleVersion"))
                Device: \(UIDevice.current.localizedModel)
                Name: \(UIDevice.current.name)
                Running: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)
                Timestamp: \(Date())
                """
                composeViewController.setMessageBody(body, isHTML: false)
                self.present(composeViewController, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Email account required",
                                              message: "Please configure an email account in Mail",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction.ok())
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    @objc func addLine(sender: AnyObject) {
        Console.addLine()
    }
}

extension ConsoleViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

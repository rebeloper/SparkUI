//
//  Console.swift
//
//
//  Created by Alex Nagy on 01/08/2020.
//

import UIKit

open class Console {
    public static var shared = Console()
    var textView: UITextView?
    var consoleController: ConsoleController
    public static var supportEmail: String?
    public static var consoleHeight: CGFloat = 220
    
    static var textAppearance: [NSAttributedString.Key: Any] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.5
        return [
            .font: UIFont(name: "Menlo", size: 12.0),
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraphStyle
        ].compactMapValues({ $0 })
    }()

    private init() {
        consoleController = ConsoleController()
    }

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    private var currentTimeStamp: String {
        return dateFormatter.string(from: Date())
    }
    
    private var currentThread: String {
        return Thread.isMainThread ? "🧵" : "🧶"
    }

    // MARK: - Create View Contoller
    public static func rootViewController(_ rootViewController: UIViewController) -> UIViewController {
        set(rootViewController: rootViewController)
        return shared.consoleController
    }

    public static func set(rootViewController: UIViewController) {
        shared.consoleController.rootViewController = rootViewController
    }
    
    // MARK: - Actions

    public static func scrollToBottom() {
        guard let
            textView = shared.textView,
            textView.boundsHeightLessThenContentSizeHeight() else { return }
        
        textView.layoutManager.ensureLayout(for: textView.textContainer)
        let offset = CGPoint(x: 0, y: (textView.contentSize.height - textView.frame.size.height))
        textView.setContentOffset(offset, animated: true)
    }
    
    public static func toggleWindowMode() {
        DispatchQueue.main.async {
            shared.consoleController.toggleWindowMode()
        }
    }

    public static func print(_ text: String, color: UIColor = UIColor.white, global: Bool = true) {
        
        let formattedText = NSMutableAttributedString(string: "\(shared.currentThread) \(shared.currentTimeStamp) \(text)")
        formattedText.addAttributes(textAppearance, range: formattedText.range)
        formattedText.addAttribute(.foregroundColor, value: color, range: formattedText.range)

        print(formattedText, global: global)
    }

    private static func print(_ text: NSAttributedString, global: Bool = true) {
        #if DEBUG
           // When we leave this method and global is true, we want to print it to console
           defer {
               if global {
                   Swift.print(text.string)
               }
           }
           
           guard let textView = shared.textView else { return }
           
           DispatchQueue.main.async {
               let newLineText = NSMutableAttributedString(attributedString: text)
               newLineText.append(.breakLine())
               
               let linesText = NSMutableAttributedString(attributedString: textView.attributedText)
               linesText.append(newLineText)
               
               textView.attributedText = linesText
               scrollToBottom()
           }
        #endif
    }

    public static func clear() {
        DispatchQueue.main.async {
            shared.textView?.clear()
            scrollToBottom()
        }
    }

    public static func error(_ text: String) {
        print("🔥 \(text)", color: UIColor.systemRed)
    }
    
    public static func warning(_ text: String) {
        print("⚠️ \(text)", color: UIColor.systemYellow)
    }
    
    public static func success(_ text: String) {
        print("🌟 \(text)", color: UIColor.systemGreen)
    }
    
    public static func working(_ text: String) {
        print("⏳ \(text)...", color: UIColor.systemGray)
    }

    public static func addLine() {
        print("-----------", color: UIColor.systemTeal)
    }
    
    public static func setHeight(height: CGFloat) {
        shared.consoleController.consoleHeight = height
    }
}

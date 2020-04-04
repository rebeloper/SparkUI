//
//  UILabel+.swift
//  
//
//  Created by Alex Nagy on 07/03/2020.
//

import UIKit

extension UILabel {
    
    @discardableResult
    open func background(color: UIColor) -> UILabel {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    open func setMultiline() -> UILabel {
        numberOfLines = 0
        return self
    }
    
    @discardableResult
    open func text(_ text: String?) -> UILabel {
        self.text = text
        return self
    }
    
    @discardableResult
    public func circular(radius: CGFloat) -> UILabel {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        size(CGSize(width: radius * 2, height: radius * 2))
        return self
    }
    
    @discardableResult
    public func insets(_ insets: UIEdgeInsets) -> UILabel {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.bottom).isActive = true
        leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: insets.right).isActive = true
        return self
    }
    
    @discardableResult
    open func size(_ size: CGSize) -> UILabel {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    open func height(_ height: CGFloat) -> UILabel {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    open func width(_ width: CGFloat) -> UILabel {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    open func font(_ font: UIFont) -> UILabel {
        self.font = font
        return self
    }
    
    @discardableResult
    open func textStyle(_ textStyle: TextStyle, ofSize: CGFloat = 17.5) -> UILabel {
        switch textStyle {
        case .regular:
            self.font = .systemFont(ofSize: ofSize)
        case .bold:
            self.font = .boldSystemFont(ofSize: ofSize)
        case .italic:
            self.font = .italicSystemFont(ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    open func underlineTextStyle(_ textStyle: TextStyle, underlineStyle: NSUnderlineStyle, ofSize: CGFloat = 17.5) -> UILabel {
        switch textStyle {
        case .regular:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: ofSize),
                .underlineStyle: underlineStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: self.text ?? "", attributes: attributes)
            self.attributedText = attributeString
        case .bold:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: ofSize),
                .underlineStyle: underlineStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: self.text ?? "", attributes: attributes)
            self.attributedText = attributeString
        case .italic:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.italicSystemFont(ofSize: ofSize),
                .underlineStyle: underlineStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: self.text ?? "", attributes: attributes)
            self.attributedText = attributeString
        }
        return self
    }
    
    @discardableResult
    open func strikethroughTextStyle(_ textStyle: TextStyle, strikethroughStyle: NSUnderlineStyle, ofSize: CGFloat = 17.5) -> UILabel {
        switch textStyle {
        case .regular:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: ofSize),
                .strikethroughStyle: strikethroughStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: self.text ?? "", attributes: attributes)
            self.attributedText = attributeString
        case .bold:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: ofSize),
                .strikethroughStyle: strikethroughStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: self.text ?? "", attributes: attributes)
            self.attributedText = attributeString
        case .italic:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.italicSystemFont(ofSize: ofSize),
                .strikethroughStyle: strikethroughStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: self.text ?? "", attributes: attributes)
            self.attributedText = attributeString
        }
        return self
    }
    
    @discardableResult
    open func regular(_ ofSize: CGFloat = 17.5, weight: UIFont.Weight? = nil) -> UILabel {
        if let weight = weight {
            self.font = .systemFont(ofSize: ofSize, weight: weight)
        } else {
            textStyle(.regular, ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    open func bold(_ ofSize: CGFloat = 17.5) -> UILabel {
        textStyle(.bold, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    open func italic(_ ofSize: CGFloat = 17.5) -> UILabel {
        textStyle(.italic, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    open func underlined(_ underlinedTextStyle: TextStyle = .regular, underlineStyle: NSUnderlineStyle = .single, ofSize: CGFloat = 17.5) -> UILabel {
        self.underlineTextStyle(underlinedTextStyle, underlineStyle: underlineStyle, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    open func strikethrough(_ strikethroughTextStyle: TextStyle = .regular, strikethroughStyle: NSUnderlineStyle = .single, ofSize: CGFloat = 17.5) -> UILabel {
        self.strikethroughTextStyle(strikethroughTextStyle, strikethroughStyle: strikethroughStyle, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    open func font(style fontStyle: FontStyle) -> UILabel {
        switch fontStyle {
        case .largeTitle:
            regular(FontStyleSize.largeTitle.rawValue)
        case .title:
            regular(FontStyleSize.title.rawValue)
        case .headline:
            bold(FontStyleSize.headline.rawValue)
        case .subheadline:
            regular(FontStyleSize.subheadline.rawValue, weight: .light)
        case .body:
            regular(FontStyleSize.body.rawValue)
        case .callout:
            regular(FontStyleSize.callout.rawValue, weight: .medium)
        case .footnote:
            regular(FontStyleSize.footnote.rawValue)
        case .caption:
            regular(FontStyleSize.caption.rawValue)
        }
        return self
    }
    
    @discardableResult
    open func text(color: UIColor) -> UILabel {
        textColor = color
        return self
    }
    
    @discardableResult
    open func shadow(color: UIColor?) -> UILabel {
        shadowColor = color
        return self
    }
    
    @discardableResult
    open func shadow(offset: CGSize) -> UILabel {
        shadowOffset = offset
        return self
    }
    
    @discardableResult
    open func textAlignment(_ textAlignment: NSTextAlignment) -> UILabel {
        self.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    open func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> UILabel {
        self.lineBreakMode = lineBreakMode
        return self
    }
    
    @discardableResult
    open func attributedText(_ text: NSAttributedString) -> UILabel {
        self.attributedText = text
        return self
    }
    
    @discardableResult
    open func highlightedText(color: UIColor?) -> UILabel {
        self.highlightedTextColor = color
        return self
    }
    
    @discardableResult
    open func isHighlighted(_ isHighlighted: Bool) -> UILabel {
        self.isHighlighted = isHighlighted
        return self
    }
    
    @discardableResult
    open func isLabelInteractionEnabled(_ enabled: Bool) -> UILabel {
        self.isUserInteractionEnabled = enabled
        return self
    }
    
    @discardableResult
    open func isEnabled(_ enabled: Bool) -> UILabel {
        self.isEnabled = enabled
        return self
    }
    
    @discardableResult
    open func isDisabled(_ isDisabled: Bool, textColor: UIColor = .systemGray) -> UILabel {
        self.isEnabled = !isDisabled
        self.textColor = textColor
        return self
    }
    
    @discardableResult
    open func isHidden(_ isHidden: Bool = true) -> UILabel {
        self.isHidden = isHidden
        return self
    }
    
    @discardableResult
    open func numberOfLines(_ numberOfLines: Int) -> UILabel {
        self.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    open func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> UILabel {
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    
    @discardableResult
    open func baselineAdjustment(_ baselineAdjustment: UIBaselineAdjustment) -> UILabel {
        self.baselineAdjustment = baselineAdjustment
        return self
    }
    
    @discardableResult
    open func minimumScaleFactor(_ factor: CGFloat) -> UILabel {
        self.minimumScaleFactor = factor
        return self
    }
    
    @discardableResult
    open func allowsDefaultTighteningForTruncation(_ allowsDefaultTighteningForTruncation: Bool) -> UILabel {
        self.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
        return self
    }
    
    @discardableResult
    open func preferredMaxLayoutWidth(_ width: CGFloat) -> UILabel {
        self.preferredMaxLayoutWidth = width
        return self
    }
    
    @discardableResult
    open func lineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) -> UILabel {

        let labelText = self.text ?? ""

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelAttributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range: NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
        return self
    }
}



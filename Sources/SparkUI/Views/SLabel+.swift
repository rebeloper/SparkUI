//
//  File.swift
//  
//
//  Created by Alex Nagy on 05/03/2020.
//

import UIKit

public extension SLabel {
    
    @discardableResult
    func background(color: UIColor) -> SLabel {
        object.backgroundColor = color
        return self
    }
    
    @discardableResult
    func setMultiline() -> SLabel {
        object.numberOfLines = 0
        return self
    }
    
    @discardableResult
    func text(_ text: String?) -> SLabel {
        self.object.text = text
        return self
    }
    
    @discardableResult
    func circular(radius: CGFloat) -> SLabel {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        size(CGSize(width: radius * 2, height: radius * 2))
        return self
    }
    
    @discardableResult
    func size(_ size: CGSize) -> SLabel {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ height: CGFloat) -> SLabel {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func width(_ width: CGFloat) -> SLabel {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> SLabel {
        self.object.font = font
        return self
    }
    
    @discardableResult
    func textStyle(_ textStyle: TextStyle, ofSize: CGFloat = 17.5) -> SLabel {
        switch textStyle {
        case .regular:
            self.object.font = .systemFont(ofSize: ofSize)
        case .bold:
            self.object.font = .boldSystemFont(ofSize: ofSize)
        case .italic:
            self.object.font = .italicSystemFont(ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    func underlineTextStyle(_ textStyle: TextStyle, underlineStyle: NSUnderlineStyle, ofSize: CGFloat = 17.5) -> SLabel {
        switch textStyle {
        case .regular:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: ofSize),
                .underlineStyle: underlineStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: self.object.text ?? "", attributes: attributes)
            self.object.attributedText = attributeString
        case .bold:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: ofSize),
                .underlineStyle: underlineStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: self.object.text ?? "", attributes: attributes)
            self.object.attributedText = attributeString
        case .italic:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.italicSystemFont(ofSize: ofSize),
                .underlineStyle: underlineStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: self.object.text ?? "", attributes: attributes)
            self.object.attributedText = attributeString
        }
        return self
    }
    
    @discardableResult
    func strikethroughTextStyle(_ textStyle: TextStyle, strikethroughStyle: NSUnderlineStyle, ofSize: CGFloat = 17.5) -> SLabel {
        switch textStyle {
        case .regular:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: ofSize),
                .strikethroughStyle: strikethroughStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: self.object.text ?? "", attributes: attributes)
            self.object.attributedText = attributeString
        case .bold:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: ofSize),
                .strikethroughStyle: strikethroughStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: self.object.text ?? "", attributes: attributes)
            self.object.attributedText = attributeString
        case .italic:
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.italicSystemFont(ofSize: ofSize),
                .strikethroughStyle: strikethroughStyle.rawValue]
            let attributeString = NSMutableAttributedString(string: self.object.text ?? "", attributes: attributes)
            self.object.attributedText = attributeString
        }
        return self
    }
    
    @discardableResult
    func regular(_ ofSize: CGFloat = 17.5, weight: UIFont.Weight? = nil) -> SLabel {
        if let weight = weight {
            self.object.font = .systemFont(ofSize: ofSize, weight: weight)
        } else {
            textStyle(.regular, ofSize: ofSize)
        }
        return self
    }
    
    @discardableResult
    func bold(_ ofSize: CGFloat = 17.5) -> SLabel {
        textStyle(.bold, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func italic(_ ofSize: CGFloat = 17.5) -> SLabel {
        textStyle(.italic, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func underlined(_ underlinedTextStyle: TextStyle = .regular, underlineStyle: NSUnderlineStyle = .single, ofSize: CGFloat = 17.5) -> SLabel {
        self.underlineTextStyle(underlinedTextStyle, underlineStyle: underlineStyle, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func strikethrough(_ strikethroughTextStyle: TextStyle = .regular, strikethroughStyle: NSUnderlineStyle = .single, ofSize: CGFloat = 17.5) -> SLabel {
        self.strikethroughTextStyle(strikethroughTextStyle, strikethroughStyle: strikethroughStyle, ofSize: ofSize)
        return self
    }
    
    @discardableResult
    func font(style fontStyle: FontStyle) -> SLabel {
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
    func text(color: UIColor) -> SLabel {
        object.textColor = color
        return self
    }
    
    @discardableResult
    func shadow(color: UIColor?) -> SLabel {
        object.shadowColor = color
        return self
    }
    
    @discardableResult
    func shadow(offset: CGSize) -> SLabel {
        object.shadowOffset = offset
        return self
    }
    
    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> SLabel {
        self.object.textAlignment = textAlignment
        return self
    }
    
    @discardableResult
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> SLabel {
        self.object.lineBreakMode = lineBreakMode
        return self
    }
    
    @discardableResult
    func attributedText(_ text: NSAttributedString) -> SLabel {
        self.object.attributedText = text
        return self
    }
    
    @discardableResult
    func highlightedText(color: UIColor?) -> SLabel {
        self.object.highlightedTextColor = color
        return self
    }
    
    @discardableResult
    func isHighlighted(_ isHighlighted: Bool) -> SLabel {
        self.object.isHighlighted = isHighlighted
        return self
    }
    
    @discardableResult
    func isLabelInteractionEnabled(_ enabled: Bool) -> SLabel {
        self.object.isUserInteractionEnabled = enabled
        return self
    }
    
    @discardableResult
    func isEnabled(_ enabled: Bool) -> SLabel {
        self.object.isEnabled = enabled
        return self
    }
    
    @discardableResult
    func isDisabled(_ isDisabled: Bool, textColor: UIColor = .systemGray) -> SLabel {
        self.object.isEnabled = !isDisabled
        self.object.textColor = textColor
        return self
    }
    
    @discardableResult
    func isHidden(_ isHidden: Bool = true) -> SLabel {
        self.object.isHidden = isHidden
        return self
    }
    
    @discardableResult
    func numberOfLines(_ numberOfLines: Int) -> SLabel {
        self.object.numberOfLines = numberOfLines
        return self
    }
    
    @discardableResult
    func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> SLabel {
        self.object.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }
    
    @discardableResult
    func baselineAdjustment(_ baselineAdjustment: UIBaselineAdjustment) -> SLabel {
        self.object.baselineAdjustment = baselineAdjustment
        return self
    }
    
    @discardableResult
    func minimumScaleFactor(_ factor: CGFloat) -> SLabel {
        self.object.minimumScaleFactor = factor
        return self
    }
    
    @discardableResult
    func allowsDefaultTighteningForTruncation(_ allowsDefaultTighteningForTruncation: Bool) -> SLabel {
        self.object.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
        return self
    }
    
    @discardableResult
    func preferredMaxLayoutWidth(_ width: CGFloat) -> SLabel {
        self.object.preferredMaxLayoutWidth = width
        return self
    }
    
    @discardableResult
    func lineSpacing(_ lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) -> SLabel {

        let labelText = self.object.text ?? ""

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelAttributedText = self.object.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range: NSMakeRange(0, attributedString.length))

        self.object.attributedText = attributedString
        return self
    }
}


//
//  UIView+.swift
//  
//
//  Created by Alex Nagy on 13/02/2020.
//

import UIKit
import Layoutless

public enum SSafeArea {
    case top, leading, trailing, bottom, exceptTop, exceptLeading, exceptTrailing, exceptBottom, vertical, horizontal, all, none
}

public enum SSpacerType {
    case extraSmall, small, normal, medium, large, extraLarge
}

public extension UIView {
    
    @discardableResult
    func edgeTo(_ view: UIView, safeArea: SSafeArea = .none) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        
        switch safeArea {
        case .top:
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        case .leading:
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        case .trailing:
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        case .bottom:
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        case .exceptTop:
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        case .exceptLeading:
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        case .exceptTrailing:
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        case .exceptBottom:
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        case .vertical:
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        case .horizontal:
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        case .all:
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        case .none:
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        return self
    }
    
    @discardableResult
    func centerIn(_ view: UIView) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return self
    }
    
    @discardableResult
    func setBackground(image: UIImage, contentMode: ContentMode = .scaleAspectFit) -> UIView {
        let imageView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
        imageView.contentMode = contentMode
        self.addSubview(imageView)
        imageView.edgeTo(self)
        return self
    }
    
    @discardableResult
    func horizontal(_ type: SSpacerType) -> UIView {
        switch type {
        case .extraSmall:
            setWidth(6)
        case .small:
            setWidth(12)
        case .normal:
            setWidth(16)
        case .medium:
            setWidth(32)
        case .large:
            setWidth(64)
        case .extraLarge:
            setWidth(86)
        }
        return self
    }
    
    @discardableResult
    func vertical(_ type: SSpacerType) -> UIView {
        switch type {
        case .extraSmall:
            setHeight(6)
        case .small:
            setHeight(12)
        case .normal:
            setHeight(16)
        case .medium:
            setHeight(32)
        case .large:
            setHeight(64)
        case .extraLarge:
            setHeight(86)
        }
        return self
    }
}

public enum SGradientDirection {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}

private let UIViewAnimationDuration: TimeInterval = 1
private let UIViewAnimationSpringDamping: CGFloat = 0.5
private let UIViewAnimationSpringVelocity: CGFloat = 0.5
public let UIViewDefaultFadeDuration: TimeInterval = 0.4

public extension UIView {
    
    @discardableResult
    func setBackground(color: UIColor) -> UIView {
        backgroundColor = color
        return self
    }
    
    @discardableResult
    func setSize(_ size: CGSize) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    @discardableResult
    func setHeight(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    @discardableResult
    func setWidth(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    @discardableResult
    func addRotate(by angle: CGFloat) -> UIView {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
        return self
    }
    
    @discardableResult
    func asImage() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
            let image = renderer.image { ctx in
                self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
            }
            return image
        } else {
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            guard let cgImage = image?.cgImage else { return nil }
            return UIImage(cgImage: cgImage)
        }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
    }
    
    func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    @discardableResult
    func setCorner(_ radius: CGFloat, maskedCorners: CACornerMask = CACornerMask_allCorners) -> UIView {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func setShadow(radius: CGFloat, color: UIColor, offset: CGSize, opacity: Float) -> UIView {
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        return self
    }
    
    @discardableResult
    func setBorder(width: CGFloat) -> UIView {
        layer.borderWidth = width
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func setBorder(color: UIColor) -> UIView {
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func setBorder(width: CGFloat, color: UIColor) -> UIView {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func setBorder(width: CGFloat, cornerRadius: CGFloat, color: UIColor, maskedCorners: CACornerMask = CACornerMask_allCorners) -> UIView {
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = maskedCorners
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    @discardableResult
    func setCapsuleBorder(width: CGFloat, color: UIColor, orientation: CapsuleBorderOrientation = .horizontal) -> UIView {
        layer.borderWidth = width
        layer.cornerRadius = (orientation == .horizontal ? frame.height : frame.width) / 2
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
        return self
    }
    
    func setBorderTop(size: CGFloat, color: UIColor) {
        borderUtility(x: 0, y: 0, width: frame.width, radius: size, color: color)
    }
    
    func setBorderTopWithPadding(size: CGFloat, color: UIColor, padding: CGFloat) {
        borderUtility(x: padding, y: 0, width: frame.width - padding*2, radius: size, color: color)
    }
    
    func setBorderBottom(size: CGFloat, color: UIColor) {
        borderUtility(x: 0, y: frame.height - size, width: frame.width, radius: size, color: color)
    }
    
    func setBorderLeft(size: CGFloat, color: UIColor) {
        borderUtility(x: 0, y: 0, width: size, radius: frame.height, color: color)
    }
    
    func setBorderRight(size: CGFloat, color: UIColor) {
        borderUtility(x: frame.width - size, y: 0, width: size, radius: frame.height, color: color)
    }
    
    fileprivate func borderUtility(x: CGFloat, y: CGFloat, width: CGFloat, radius: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: radius)
        layer.addSublayer(border)
    }
    
    func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
    
    func addSpring(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        addSpring(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }
    
    func addSpring(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: UIViewAnimationDuration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIView.AnimationOptions.allowAnimatedContent,
            animations: animations,
            completion: completion
        )
    }
    
    func addAnimations(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
    
    func addAnimations(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        addAnimations(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }
    
    func addPop() {
        setScale(x: 1.1, y: 1.1)
        addSpring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
        })
    }
    
    func addPopBig() {
        setScale(x: 1.25, y: 1.25)
        addSpring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
        })
    }
    
    func addReversePop() {
        setScale(x: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.05, delay: 0, options: .allowUserInteraction, animations: {[weak self] in
            self?.setScale(x: 1, y: 1)
            }, completion: { (_) in })
    }
    
    func addShakeForTimes(_ times: Int) {
        let anim = CAKeyframeAnimation(keyPath: "transform")
        anim.values = [
            NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0 )),
            NSValue(caTransform3D: CATransform3DMakeTranslation( 5, 0, 0 ))
        ]
        anim.autoreverses = true
        anim.repeatCount = Float(times)
        anim.duration = 7/100
        
        self.layer.add(anim, forKey: nil)
    }
    
    func addFadeIn(_ duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        addFadeTo(1.0, duration: duration, delay: delay, completion: completion)
    }
    
    func addFadeOut(_ duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        addFadeTo(0.0, duration: duration, delay: delay, completion: completion)
    }
    
    func addFadeTo(_ value: CGFloat, duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration ?? UIViewDefaultFadeDuration, delay: delay ?? UIViewDefaultFadeDuration, options: .curveEaseInOut, animations: {
            self.alpha = value
        }, completion: completion)
    }
    
    @discardableResult
    func setCircular(_ radius: CGFloat) -> UIView {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        setSize(CGSize(width: radius * 2, height: radius * 2))
        return self
    }
    
    @discardableResult
    func setSquare(_ lenght: CGFloat) -> UIView {
        layer.masksToBounds = true
        setSize(CGSize(width: lenght, height: lenght))
        return self
    }
    
    @discardableResult
    func setAlpha(_ alpha: CGFloat) -> UIView {
        self.alpha = alpha
        return self
    }
    
    @discardableResult
    func setHidden(_ setHidden: Bool = true) -> UIView {
        self.isHidden = setHidden
        return self
    }
    
    func gradientBackground(from color1: UIColor, to color2: UIColor, direction: SGradientDirection) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [color1.cgColor, color2.cgColor]
        
        switch direction {
        case .leftToRight:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .bottomToTop:
            gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        default:
            break
        }
        
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func rotate(duration: CFTimeInterval, speed: Double, clockWise: Bool) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2 * speed * (clockWise ? 1.0 : -1.0))
        rotation.duration = duration
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    @discardableResult
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool = true) -> UIView {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }
}


public extension UIView {
    @discardableResult
    func centerHorizontally(withViewHeight height: CGFloat) -> UIView {
        let container = UIView()
        container.setHeight(height)
        stack(.vertical)(
            self
        ).centeringInParent().layout(in: container)
        return container
    }
    
    @discardableResult
    func centerVertically(withViewWidth width: CGFloat) -> UIView {
        let container = UIView()
        container.setWidth(width)
        stack(.vertical)(
            self
        ).centeringInParent().layout(in: container)
        return container
    }
}

public extension UIView {
    func longPressGestureState() -> LongPressGestureState {
        var state = LongPressGestureState.none
        if let gestureRecognizers = gestureRecognizers {
            gestureRecognizers.forEach { (gestureRecognizer) in
                if let gestureRecognizer = gestureRecognizer as? UILongPressGestureRecognizer {
                    switch gestureRecognizer.state.rawValue {
                    case 1:
                        state = .didBegin
                    case 2:
                        state = .pressing
                    case 3:
                        state = .didEnd
                    default:
                        state = .none
                    }
                }
            }
        }
        return state
    }
}

public extension UIView {
    func length(_ percentage: Percentage = .full, of side: Side) -> CGFloat {
        switch side {
        case .width:
            return frame.size.width * percentage.rawValue
        case .height:
            return frame.size.height * percentage.rawValue
        }
    }
    
    func length(percentage: CGFloat, of side: Side) -> CGFloat {
        switch side {
        case .width:
            return frame.size.width * percentage
        case .height:
            return frame.size.height * percentage
        }
    }
}

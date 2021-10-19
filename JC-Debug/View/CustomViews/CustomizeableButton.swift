//
//  CustomizeableButton.swift
//  Smart Consumer
//
//  Created by Niko Cudiamat on 5/12/20.
//  Copyright © 2020 Smart. All rights reserved.
//
import UIKit

@IBDesignable

// ==========================================================================================================

class CustomizeableButton: BorderedButton {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard animatesWhenTapped else { return true }
        self.animateTouchDown()
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard animatesWhenTapped else { return }
        self.animateTouchUp()
    }
}

// ==========================================================================================================

@IBDesignable

class BorderedButton: UIButton {
        
    @IBInspectable var selectedBackgroundColor: UIColor = .clear {
        didSet {
            // self.backgroundColor = selectedBackgroundColor
        }
    }
    
    @IBInspectable var nonSelectedBackgroundColor: UIColor = .clear {
        didSet {
            self.backgroundColor = nonSelectedBackgroundColor
        }
    }
    
    @IBInspectable var selectedTextColor: UIColor = .clear {
        didSet {
            self.setTitleColor(selectedTextColor, for: .selected)
        }
    }
    
    @IBInspectable var nonSelectedTextColor: UIColor = .clear {
        didSet {
            self.setTitleColor(nonSelectedTextColor, for: .normal)
        }
    }
    
    @IBInspectable var selectedButtonImage: UIImage? {
        didSet {
            self.setImage(selectedButtonImage, for: .selected)
        }
    }
    
    @IBInspectable var nonSelectedButtonImage: UIImage? {
        didSet {
            self.setImage(nonSelectedButtonImage, for: .normal)
        }
    }
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = selectedBackgroundColor
                self.setTitleColor(selectedTextColor, for: .normal)
            } else {
                self.backgroundColor = nonSelectedBackgroundColor
                self.setTitleColor(nonSelectedTextColor, for: .normal)
            }
        }
    }
    
    @IBInspectable var animatesWhenTapped: Bool = true
}


protocol ViewRefreshProtocol {
    func refreshView()
}

extension ViewRefreshProtocol where Self: UIView {
    
    func refreshView() {
        self.setNeedsDisplay()
        self.setNeedsLayout()
    }
    
}


extension BorderedButton: BorderProtocol, ViewRefreshProtocol {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue > 10 ? newValue : 10
            self.layer.masksToBounds = newValue > 0
            self.refreshView()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            self.layer.borderWidth = newValue
            self.refreshView()
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            guard let currentBorderColor = self.layer.borderColor else {
                return UIColor.clear
            }
            
            return UIColor(cgColor: currentBorderColor)
        }
        
        set {
            self.layer.borderColor = newValue.cgColor
            self.refreshView()
        }
    }
}



protocol ShadowProtocol {
    var maskToBounds: Bool { get set }
    var shadowRadius: CGFloat { get set }
    var shadowOpacity: CGFloat { get set }
    var shadowOffset: CGSize { get set }
}

extension CustomizeableButton: ShadowProtocol {
    
    @IBInspectable var maskToBounds: Bool {
        get {
            return self.layer.masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: CGFloat {
        get {
            return CGFloat(self.layer.shadowOpacity)
        }
        set {
            self.layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
}
protocol BorderProtocol {
    
    var cornerRadius: CGFloat { get set }
    
    var borderWidth: CGFloat { get set }
    
    var borderColor: UIColor { get set }

    var shadowColor: UIColor { get set }
    
    var shadowRadius: CGFloat { get set }
}

extension BorderProtocol where Self: UIView {
    
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor {
        get {
            guard let currentBorderColor = self.layer.borderColor else {
                return UIColor.clear
            }
            
            return UIColor(cgColor: currentBorderColor)
        }
        
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    var shadowColor: UIColor {
        get {
            guard let currentShadowColor = self.layer.shadowColor else {
                return UIColor.clear
            }
            
            return UIColor(cgColor: currentShadowColor)
        }
        
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        
        set {
            self.layer.shadowRadius = newValue
        }
    }

}

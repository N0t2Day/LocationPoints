//
//  UIView.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 20.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import UIKit.UIView

extension UIView {
    func shake(deadline: DispatchTime) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.15
        animation.repeatCount = 1.5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 20, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 20, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
        let oldColor = self.layer.borderColor
        self.layer.borderColor = UIColor.red.cgColor
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            self.layer.borderColor = oldColor
        }
    }
    static var nib: UINib! {
        return UINib(nibName: reuseId, bundle: nil)
    }
    
    static var reuseId: String! {
        return String(describing: self)
    }
}

extension UIView {
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    //MARK: - IBInspectable
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

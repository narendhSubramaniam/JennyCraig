

import UIKit

extension UIView {
    func slideInFromBottom(duration: TimeInterval = 0.25, delay: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) {
        self.transform = CGAffineTransform(translationX: 0, y: self.frame.maxY)
                                           
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.8,
            options: .curveEaseInOut,
            animations: {
                self.transform = .identity
            },
            completion: completion)
    }

    func slideOutToBottom(offset: CGFloat = 0, duration: TimeInterval = 0.25, delay: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: duration,
            delay: delay,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.8,
            options: .curveEaseInOut,
            animations: {
                self.transform = CGAffineTransform(translationX: 0, y: self.frame.maxY)
            },
            completion: completion)
    }
    
    func animateVisibility(isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            isHidden ? self?.hide() : self?.show()
        }
    }
    
    func show() {
        if !isHidden,
            self.alpha == 1,
            self.isHidden == false {
            return
        }
        
        self.alpha = 0
        self.isHidden = true
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: [.curveEaseInOut, .allowUserInteraction], animations: { [weak self] in
            self?.alpha = 1
            self?.isHidden = false
            }, completion: nil)
    }
    
    func hide() {
        if isHidden,
            self.alpha == 0,
            self.isHidden == true {
            return
        }
        
        self.alpha = 1
        self.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: [.curveEaseInOut, .allowUserInteraction], animations: { [weak self] in
            self?.alpha = 0
            self?.isHidden = true
            }, completion: nil)
    }
    
    func animateAlpha(value: CGFloat) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: { [weak self] in
        self?.alpha = value
        }, completion: nil)
    }
    
    func animateShadow(isShown: Bool, timing: CAMediaTimingFunctionName = .default, duration: CFTimeInterval = 0.3, lowValue: Float = 0) {
        let shadowOpacityAnimation = CABasicAnimation()
        shadowOpacityAnimation.fromValue = isShown ? lowValue : self.layer.shadowOpacity
        shadowOpacityAnimation.toValue = isShown ? self.layer.shadowOpacity : lowValue
        shadowOpacityAnimation.isRemovedOnCompletion = false
        shadowOpacityAnimation.fillMode = .forwards
        shadowOpacityAnimation.duration = duration
        shadowOpacityAnimation.timingFunction = CAMediaTimingFunction(name: timing)
        self.layer.add(shadowOpacityAnimation, forKey: "shadowOpacity")
    }
    
    func animateTouchDown(duration: Double = 0.1) {
        self.transform = .identity
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: { [weak self] in
                self?.transform = .init(scaleX: 0.9, y: 0.9)
            }, completion: nil)
        animateShadow(isShown: false, timing: .easeOut, duration: duration, lowValue: self.layer.shadowOpacity / 3.0)
    }
    
    func animateTouchUp(duration: Double = 0.2) {
        self.transform = .init(scaleX: 0.9, y: 0.9)
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: { [weak self] in
                self?.transform = .identity
            }, completion: nil)
        animateShadow(isShown: true, timing: .easeOut, duration: duration, lowValue: self.layer.shadowOpacity / 3.0)
    }
    
    func shake() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.08
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
    
    func shake3D() {
        let shakeToTheLeft = CASpringAnimation(keyPath: "transform")
        shakeToTheLeft.damping = 0.1
        shakeToTheLeft.initialVelocity = 0.7
        shakeToTheLeft.fromValue = CATransform3DIdentity
        let leftRotation = CATransform3DMakeRotation((2 * CGFloat.pi)-0.17, 0, 1, 0)
        let leftTranslation = CATransform3DMakeTranslation(-20, 0, 0)
        shakeToTheLeft.toValue = CATransform3DConcat(leftRotation, leftTranslation)
        shakeToTheLeft.duration = 0.1
        shakeToTheLeft.autoreverses = true
        shakeToTheLeft.repeatCount = 0
//        shakeToTheLeft.timingFunction = CAMediaTimingFunction(name: .easeOut)

        let shakeToTheRight = CASpringAnimation(keyPath: "transform")
        shakeToTheRight.damping = 0.1
        shakeToTheRight.initialVelocity = 0.7
        shakeToTheRight.beginTime = shakeToTheLeft.beginTime + (shakeToTheLeft.duration * 2)
        shakeToTheRight.fromValue = CATransform3DIdentity
        let rightRotation = CATransform3DMakeRotation(0.17, 0, 1, 0)
        let rightTranslation = CATransform3DMakeTranslation(20, 0, 0)
        shakeToTheRight.toValue = CATransform3DConcat(rightRotation, rightTranslation)
        shakeToTheRight.duration = 0.1
        shakeToTheRight.autoreverses = true
        shakeToTheRight.repeatCount = 0
//        shakeToTheRight.timingFunction = CAMediaTimingFunction(name: .easeOut)

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = (shakeToTheLeft.duration * 2) + (shakeToTheRight.duration * 2)
        animationGroup.animations = [shakeToTheLeft, shakeToTheRight]
//        animationGroup.repeatCount = 1
//        animationGroup.timingFunction = CAMediaTimingFunction(name: .linear)
        layer.add(animationGroup, forKey: "transform")
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    /**
      Fades this view in. This method can be chained with other animations to combine a fade with
      the other animation, for instance:
      ```
      view.fadeIn().slideIn(from: .left)
      ```
      - Parameters:
        - duration: duration of the animation, in seconds
        - delay: delay before the animation starts, in seconds
        - completion: block executed when the animation ends
     */
    @discardableResult func fadeIn(duration: TimeInterval = 0.25,
                                   delay: TimeInterval = 0,
                                   completion: ((Bool) -> Void)? = nil) -> UIView {
      isHidden = false
      alpha = 0
      UIView.animate(
        withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
          self.alpha = 1
        }, completion: completion)
      return self
    }

    /**
     Fades this view out. This method can be chained with other animations to combine a fade with
     the other animation, for instance:
     ```
     view.fadeOut().slideOut(to: .right)
     ```
     - Parameters:
       - duration: duration of the animation, in seconds
       - delay: delay before the animation starts, in seconds
       - completion: block executed when the animation ends
     */
    @discardableResult func fadeOut(duration: TimeInterval = 0.25,
                                    delay: TimeInterval = 0,
                                    completion: ((Bool) -> Void)? = nil) -> UIView {
      UIView.animate(
        withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
          self.alpha = 0
        }, completion: completion)
      return self
    }
}

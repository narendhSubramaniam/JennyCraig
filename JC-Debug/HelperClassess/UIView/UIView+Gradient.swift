

import UIKit

extension UIView {
    func withGradientLayer(bounds: CGRect, colors: [CGColor], locations: [NSNumber], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.masksToBounds = true
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

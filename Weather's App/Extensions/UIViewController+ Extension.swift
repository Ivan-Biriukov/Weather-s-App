import UIKit

extension UIViewController {
    
    // Color Gradient Functions
    
    func setMainGradientBackground() {
        let colorTop =  UIColor(red: 74/256, green: 72/256, blue: 71/256, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 44/256, green: 45/256, blue: 53/256, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

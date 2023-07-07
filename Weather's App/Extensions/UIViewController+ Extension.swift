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
    
    
    
    // Buttons Settings methods
    
     func changeButtonsTitleStyle(titleText text: String, button: UIButton, selected: Bool) {
        
        let selectedButtonAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.poppinsMedium14() ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.white,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let unselectedButtonAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.poppinsRegular14() ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.unselectedGray,
        ]
        
        let selectedButton = NSMutableAttributedString(
            string: text ,
            attributes: selectedButtonAttributes)
    
        let unselectedButton = NSMutableAttributedString(
            string: text,
            attributes: unselectedButtonAttributes)
        
        if selected {
            button.setAttributedTitle(selectedButton, for: .normal)
        } else {
            button.setAttributedTitle(unselectedButton, for: .normal)
        }
    }
    
    // MARK: - Keyboard Hide Section
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)

        if let nav = self.navigationController {
            nav.view.endEditing(true)
        }
    }
}

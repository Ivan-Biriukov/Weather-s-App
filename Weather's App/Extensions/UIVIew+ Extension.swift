import UIKit

extension UIView {
    
    // MARK: - Customising UI Elements
    
     func feelsLikeAtributtedString(forLAbel label: UILabel,grayText: String, whiteText: String) {
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.poppinsRegular12(), NSAttributedString.Key.foregroundColor : UIColor.darkGrayText]

        let attrs2 = [NSAttributedString.Key.font : UIFont.poppinsRegular12(), NSAttributedString.Key.foregroundColor : UIColor.white]

        let attributedString1 = NSMutableAttributedString(string: grayText, attributes:attrs1 as [NSAttributedString.Key : Any])

        let attributedString2 = NSMutableAttributedString(string: whiteText, attributes:attrs2 as [NSAttributedString.Key : Any])

        attributedString1.append(attributedString2)
        label.attributedText = attributedString1
    }
    
    
    func addDashedBorder(startX: Int, startY: Int, endX: Int, endY: Int) {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.darkGray.cgColor
        shapeLayer.lineWidth = 2.5
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [16,16]

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: startX, y: startY),
                                CGPoint(x: endX, y: endY)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    
}

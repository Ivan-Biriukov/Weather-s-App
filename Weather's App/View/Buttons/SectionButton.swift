import UIKit

class SectionButton: UIButton {
    
    enum ButtonStatus {
        case selected
        case unselected
    }
    
    private let status : ButtonStatus
    private let title : String
    
    init(title: String, status: ButtonStatus) {
        self.status = status
        self.title = title
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        if status == .selected {
            let selectedButtonAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.poppinsMedium14() ?? UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.white,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            let attributedTitle = NSMutableAttributedString(
                string: title,
                attributes: selectedButtonAttributes)
            setAttributedTitle(attributedTitle, for: .normal)

        } else {
            setTitle(title, for: .normal)
            titleLabel?.font = .poppinsRegular14()
            setTitleColor(.unselectedGray, for: .normal)
        }
      
    }
    
    
}

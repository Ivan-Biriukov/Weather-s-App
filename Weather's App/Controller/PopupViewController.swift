

import UIKit

class PopupViewController: UIViewController {
    
    private lazy var dismissButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark.seal.fill"), for: .normal)
        btn.tintColor = .white
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(dismissButtonTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let locationTitle : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold16()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Location"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .additionalViewBackground
        addSubviews()
        setupConstraints()
    }
    
    
    // MARK: - COnfigure UI
    
    private func addSubviews() {
        view.addSubview(dismissButton)
        view.addSubview(locationTitle)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            locationTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            locationTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
        
        ])
    }
    
    // MARK: - Buttons Methods
    
    @objc func dismissButtonTaped() {
        dismiss(animated: true)
    }

}

import UIKit

class WheaterHourlyCollectionViewCell: UICollectionViewCell {
    
    var cellData : WheaterHourlyCollectionModel? {
        didSet {
            timeLabel.text = cellData?.timeValue
            wheatherConditionImg.image = cellData?.weatherConditionImg
            temperatureLabel.text = cellData?.getRoundedTempValueString()
        }
    }
    
    private let timeLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular8()
        lb.textColor = .darkGrayText
        lb.textAlignment = .center
        lb.text = "01:00"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let wheatherConditionImg : UIImageView = {
        let img = UIImageView(image: UIImage(named: K.WheatherConditionsImages.snow))
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 20).isActive = true
        img.widthAnchor.constraint(equalToConstant: 25).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let temperatureLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold12()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "29°"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let contentStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 11
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    private func configure() {
        contentView.backgroundColor = .customViewsUnselectedBackground
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(contentStack)
        contentStack.addArrangedSubview(timeLabel)
        contentStack.addArrangedSubview(wheatherConditionImg)
        contentStack.addArrangedSubview(temperatureLabel)

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
        ])
    }
}



import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    private let wheatherConditionImg : UIImageView = {
        let img = UIImageView(image: UIImage(named: K.WheatherConditionsImages.storm))
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 15).isActive = true
        img.widthAnchor.constraint(equalToConstant: 25).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let dayOfTheWeakLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular10()
        lb.textColor = .darkGrayText
        lb.textAlignment = .center
        lb.text = "SUN"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let dayDateLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular8()
        lb.textColor = .darkGrayText
        lb.textAlignment = .center
        lb.text = "18.04"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
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
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(wheatherConditionImg)
        contentView.addSubview(dayOfTheWeakLabel)
        contentView.addSubview(dayDateLabel)
        contentView.addSubview(temperatureLabel)

        NSLayoutConstraint.activate([
            wheatherConditionImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            wheatherConditionImg.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayOfTheWeakLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayOfTheWeakLabel.topAnchor.constraint(equalTo: wheatherConditionImg.bottomAnchor, constant: 7),
            dayDateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayDateLabel.topAnchor.constraint(equalTo: dayOfTheWeakLabel.bottomAnchor, constant: 5),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: dayDateLabel.bottomAnchor, constant: 6),
        ])
    }
}

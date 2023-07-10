import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    private let weekDayLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsMedium12()
        lb.textColor = .darkGrayText
        lb.text = "SUN"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let dayDateLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textColor = .white
        lb.text = "SEP 12"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let leftStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 7
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let weatherConditionImg : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: K.WheatherConditionsImages.rain)
        img.heightAnchor.constraint(equalToConstant: 25).isActive = true
        img.widthAnchor.constraint(equalToConstant: 40).isActive = true
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let weatherConditionNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textColor = .goldText
        lb.text = "Thunderstorms"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let windInfoLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsMedium12()
        lb.textColor = .darkGrayText
        lb.text = "ssw 11 km/h"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let middleStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 7
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let temperatureLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textColor = .white
        lb.text = "33° / 28°"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let humidityImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "drop.fill")
        img.tintColor = .white
        img.heightAnchor.constraint(equalToConstant: 12).isActive = true
        img.widthAnchor.constraint(equalToConstant: 10).isActive = true
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let humidityValueLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textColor = .white
        lb.text = "30%"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    
    private let humidityStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let rightStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 7
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let mainStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .additionalViewBackground
        contentView.addSubview(mainStack)
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 20
        mainStack.addArrangedSubview(leftStack)
        mainStack.addArrangedSubview(weatherConditionImg)
        mainStack.addArrangedSubview(middleStack)
        mainStack.addArrangedSubview(rightStack)
        leftStack.addArrangedSubview(weekDayLabel)
        leftStack.addArrangedSubview(dayDateLabel)
        middleStack.addArrangedSubview(weatherConditionNameLabel)
        middleStack.addArrangedSubview(windInfoLabel)
        rightStack.addArrangedSubview(temperatureLabel)
        rightStack.addArrangedSubview(humidityStack)
        humidityStack.addArrangedSubview(humidityImage)
        humidityStack.addArrangedSubview(humidityValueLabel)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}

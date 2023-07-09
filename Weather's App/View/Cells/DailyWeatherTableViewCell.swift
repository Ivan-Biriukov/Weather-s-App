import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    
    private let container : UIView = {
        let container = UIView()
        container.backgroundColor = .additionalViewBackground
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let dayLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsMedium14()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Today"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let wheatherConditionImg : UIImageView = {
        let img = UIImageView(image: UIImage(named: K.WheatherConditionsImages.sunnny))
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 20).isActive = true
        img.widthAnchor.constraint(equalToConstant: 25).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let minTempLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold14()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "27°"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let maxTempLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold14()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "36°"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        contentView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(container)
        container.addSubview(dayLabel)
        container.addSubview(wheatherConditionImg)
        container.addSubview(minTempLabel)
        container.addSubview(maxTempLabel)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            dayLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 38),
            wheatherConditionImg.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            wheatherConditionImg.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            maxTempLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            maxTempLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -26),
            
            minTempLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            minTempLabel.trailingAnchor.constraint(equalTo: maxTempLabel.leadingAnchor, constant: -23.5),
        
        ])
    }
}

class DailyWeatherTableViewFirstIndexCell: UITableViewCell {
    
    private let tempLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular14()
        lb.textAlignment = .right
        lb.textColor = .darkGrayText
        lb.text = "High  |  Low"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .additionalViewBackground
        contentView.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


import UIKit

class LocationTableViewCell: UITableViewCell {
    
    private let locationImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: K.Images.locationImg)
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 22).isActive = true
        img.widthAnchor.constraint(equalToConstant: 18).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

   let cityNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold14()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Chennai"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let countyNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold14()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "TN"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let firstLaneStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let temperatureLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textColor = .darkGrayText
        lb.textAlignment = .center
        lb.text = "29°"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let weatherConditionLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textColor = .darkGrayText
        lb.textAlignment = .center
        lb.text = "Clear"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let secondLaneStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let mainRightStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
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
        contentView.backgroundColor = .additionalViewBackground
        contentView.addSubview(locationImage)
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(countyNameLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherConditionLabel)
    
        
        
        NSLayoutConstraint.activate([
            locationImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),
            locationImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21),
            cityNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 20),
            countyNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countyNameLabel.leadingAnchor.constraint(equalTo: cityNameLabel.trailingAnchor, constant: 5),
            temperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 5),
            temperatureLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 20),
            weatherConditionLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 5),
            weatherConditionLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 5),

        ])
    }

}

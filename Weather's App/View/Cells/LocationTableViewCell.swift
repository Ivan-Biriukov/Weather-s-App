
import UIKit

class LocationTableViewCell: UITableViewCell {
    
    private let locationImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: K.Images.locationImg)
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 22).isActive = true
        img.widthAnchor.constraint(equalToConstant: 18).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    private let cityNameLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold14()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Chennai"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let countyNameLabel : UILabel = {
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
    
    private let temperatureLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textColor = .darkGrayText
        lb.textAlignment = .center
        lb.text = "29°"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let weatherConditionLabel : UILabel = {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

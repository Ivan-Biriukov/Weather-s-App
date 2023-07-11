import UIKit

class NotificationTableViewCell: UITableViewCell {
    
     let image : UIImageView = {
        let img = UIImageView()
        img.heightAnchor.constraint(equalToConstant: 25).isActive = true
        img.widthAnchor.constraint(equalToConstant: 25).isActive = true
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold16()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .additionalViewBackground
        
        NSLayoutConstraint.activate([
            //image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
          //  titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10)
        ])
    }

}

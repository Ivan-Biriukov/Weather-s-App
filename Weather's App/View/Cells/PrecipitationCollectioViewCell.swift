import UIKit

class PrecipitationCollectioViewCell: UICollectionViewCell {
    
    var progressHeight : CGFloat = 20
    
    private let dayOfTheWeekLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular10()
        lb.textAlignment = .center
        lb.textColor = .systemGray5
        lb.text = "SUN"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
   
    private let dayDateLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular8()
        lb.textAlignment = .center
        lb.textColor = .darkGrayText
        lb.text = "13 SEP"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
     let progressVerticalView : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.widthAnchor.constraint(equalToConstant: 44).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let percentageValue : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold14()
        lb.textAlignment = .center
        lb.textColor = .white
        lb.text = "30%"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
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
        
        contentView.addSubview(dayOfTheWeekLabel)
        contentView.addSubview(dayDateLabel)
        contentView.addSubview(progressVerticalView)
        contentView.addSubview(percentageValue)
        

        NSLayoutConstraint.activate([
            dayOfTheWeekLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dayOfTheWeekLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayDateLabel.topAnchor.constraint(equalTo: dayOfTheWeekLabel.bottomAnchor, constant: 6),
            dayDateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            percentageValue.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            percentageValue.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            progressVerticalView.bottomAnchor.constraint(equalTo: percentageValue.topAnchor, constant: -10),
            progressVerticalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            progressVerticalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
            progressVerticalView.heightAnchor.constraint(equalToConstant: progressHeight),
        ])
    }
}

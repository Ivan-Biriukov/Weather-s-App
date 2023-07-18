import UIKit

class PrecipitationCollectioViewCell: UICollectionViewCell {
    
    var cellData : PrecipitationCollectionDataModel? {
        didSet {
            self.dayOfTheWeekLabel.text = cellData?.date
            self.percentageValue.text = "\(cellData!.progressValue)" + "%"
        }
    }
    
    private let dayOfTheWeekLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular10()
        lb.textAlignment = .center
        lb.textColor = .systemGray5
        lb.numberOfLines = 0
        lb.text = "SUN"
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
        contentView.addSubview(progressVerticalView)
        contentView.addSubview(percentageValue)
        

        NSLayoutConstraint.activate([
            dayOfTheWeekLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dayOfTheWeekLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            percentageValue.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            percentageValue.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            progressVerticalView.bottomAnchor.constraint(equalTo: percentageValue.topAnchor, constant: -10),
            progressVerticalView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            progressVerticalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
        ])
    }
}

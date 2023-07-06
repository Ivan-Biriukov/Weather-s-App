import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    var cellData : OnboardingDataModel? {
        didSet {
            self.image.image = cellData?.imageName
        }
    }
    
   private let image : UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
       img.contentMode = .center
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(image)
        self.backgroundView = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

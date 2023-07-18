
import Foundation

struct PrecipitationCollectionDataModel {
    let date : String
    let viewHeight : CGFloat
    let progressValue : Int
    
    func fetchViewHeight(currentPercentage : Int) -> CGFloat {
        if currentPercentage == 0 {
            return CGFloat(0)
        } else if currentPercentage == 100 {
            return CGFloat(150)
        } else {
            let calculatedValue = Double(150) * (Double(currentPercentage) / Double(100))
            return calculatedValue
        }
    }
}

import UIKit

struct WheaterHourlyCollectionModel {
    let timeValue : String
    let weatherConditionImg : UIImage
    let tempValueLabel : Double
    
    func getRoundedTempValueString() -> String {
      return  String(format: "%.1f", tempValueLabel)
    }
}

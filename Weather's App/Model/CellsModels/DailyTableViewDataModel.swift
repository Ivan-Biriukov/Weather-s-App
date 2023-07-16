import UIKit

struct DailyTableViewDataModel {
    let date : String
    let weatherConditionImage : UIImage
    let minTempValue : Double
    let maxTempvalue : Double
    
    func minTempTOString() -> String {
      return  String(format: "%.1f", minTempValue)
    }
    
    func maxTempTOString() -> String {
      return  String(format: "%.1f", maxTempvalue)
    }
}

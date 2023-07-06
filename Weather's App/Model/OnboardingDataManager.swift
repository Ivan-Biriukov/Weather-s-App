import UIKit

struct OnboardingDataModel {
    let imageName : UIImage
    let mainTitleText : String
    let descriptionText : String
    let nextButtonImage : String
}

struct OnboardingDataManager {
    
    static let dataArray : [OnboardingDataModel] = [
        .init(imageName: UIImage(named: K.Onboarding.moonImg)!, mainTitleText: "Detailed Hourly Forecast", descriptionText: "Get in - depth weather information.", nextButtonImage: K.Onboarding.ButtonsImages.firstStage),
        .init(imageName: UIImage(named: K.Onboarding.sunImg)!, mainTitleText: "Real-Time Weather Map", descriptionText: "Watch the progress of the precipitation to stay informed", nextButtonImage: K.Onboarding.ButtonsImages.secondStage),
        .init(imageName: UIImage(named: K.Onboarding.rainImg)!, mainTitleText: "Weather Around the World", descriptionText: "Add any location you want and swipe easily to chnage.", nextButtonImage: K.Onboarding.ButtonsImages.thirdStage),
        .init(imageName: UIImage(named: K.Onboarding.cloudsImg)!, mainTitleText: "Detailed Hourly Forecast", descriptionText: "Get in - depth weather information.", nextButtonImage: K.Onboarding.ButtonsImages.lastStage)
    
    ]
}

import Foundation

struct K {
    static let apiKey : String = "48c416dce3eb3c49c52da05f47b1c033"
    
    struct Onboarding {
        static let moonImg = "MoonLogo"
        static let sunImg = "SunLogo"
        static let rainImg = "RainLogo"
        static let cloudsImg = "CloudsLogo"
        
        struct ButtonsImages {
            static let firstStage = "NextButtonFirst"
            static let secondStage = "NextButtonSecond"
            static let thirdStage = "NextButtonThird"
            static let lastStage = "NextButtonLast"
        }
        
        struct CollectionIndicators {
            static let selected = "SelectedItemIndicator"
            static let unselected = "UnselectedItemIndicator"
        }
    }
    
    struct Views {
        static let mainBackground : String = "mainBackground"
    }
    
    struct NavigationBar {
        static let accountButton : String = "navBarProfileButtonIcon"
        static let threeDotsButton : String = "navBarThreeDotsIcon"
    }
    
    struct WheatherConditionsImages {
        static let sunnny : String = "Sunny"
        static let clouds : String = "cloudy"
        static let rain : String = "rain"
        static let snow : String = "snow"
        static let storm : String = "storm"
    }
    
    struct TodayView {
        static let precipitationPosibilityImg : String = "precipitation"
        static let humidityImg : String = "humidity"
        static let windImg : String = "wind"
        static let sunsetImg : String = "sunset"
    }
    
    struct Images {
        static let locationImg : String = "Shape"
    }
    
}

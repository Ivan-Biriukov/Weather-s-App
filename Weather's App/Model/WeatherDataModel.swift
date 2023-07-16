import UIKit

struct WeatherModel { // created the model for our finel object view (all properties we nned translated from JSON saved here)
    let conditionId: Int
    let conditionName: String
    let countryName: String
    let cityName: String
    let temperature: Double
    let feelLikeTemp: Double
    let minTemp: Double
    let maxTemp: Double
    let windSpeed: Double
    let humidity: Int
    let sunrise: Int
    let sunset: Int
    
    
    var weatherImage : UIImage {
        switch conditionName {
        case "Rain":
            return UIImage(named: "rain")!
        case "Shower rain":
            return UIImage(named: "rain")!
        case "Clear":
            return UIImage(named: "Sunny")!
        case "Thunderstorm":
            return UIImage(named: "storm")!
        case "snow":
            return UIImage(named: "snow")!
        default:
            return UIImage(named: "cloudy")!
        }
    }

    var temperatureString: String{
       return String(format: "%.1f", temperature)
    }
    
    var feelLikeTempString: String {
        return String(format: "%.1f", feelLikeTemp)
    }
    
    var minTempString: String {
        return String(format: "%.1f", minTemp)
    }
    
    var maxTempString: String {
        return String(format: "%.1f", maxTemp)
    }
    
    var humidityPercentString: String {
        return "\(humidity)%"
    }
    
    var  windSpeedString: String{
        return String(format: "%.1f", windSpeed)
    }
        
    func timeStringFromUnixTime(timeInterval : Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateFormatter = DateFormatter()
        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date as Date)
    }
    
    func precipitationPrecentage() -> String {
        switch conditionName {
        case "Rain":
            return "100%"
        case "Snow":
            return "100%"
        case "Thunderstorm":
            return "100%"
        case "Shower rain":
            let value = Int.random(in: 75...100)
            return "\(value)%"
        case "Clear":
            let value = Int.random(in: 0...10)
            return "\(value)%"
        default:
            let value = Int.random(in: 35...78)
            return "\(value)%"
        }
    }

}


struct DailyWeatherModel {
    let cityName : String
    let countryName : String
    let sunriseTime : Int
    let sunsetTime : Int
    let population : Int
    let days : [Days]
    
    func doubleToRoundedString(value : Double) -> String{
        return String(format: "%.1f", value)
    }
    
    func timeStringFromUnixTime(timeInterval : Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH : mm"
        return dateFormatter.string(from: date as Date)
    }
}

struct Days {
    let dayDate : Int
    let timeIntervals : [String] 
    let HourlyTemp : [Double]
    let FeelsLikeHourleTemp : [Double]
    let minHourlyTemp : [Double]
    let maxHourlyTemp : [Double]
    let hourlyHumidityValues : [Int]
    let hourlyWeatherConditionName: [String]
    let hourlyWindSpeed : [Double]
    let visibiliti : [Int]
    
    
    func weatherImage(ElementNumber num: Int) -> UIImage {
        switch hourlyWeatherConditionName[num] {
        case "Rain":
            return UIImage(named: "rain")!
        case "Shower rain":
            return UIImage(named: "rain")!
        case "Clear":
            return UIImage(named: "Sunny")!
        case "Thunderstorm":
            return UIImage(named: "storm")!
        case "snow":
            return UIImage(named: "snow")!
        default:
            return UIImage(named: "cloudy")!
        }
    }
    
    func todayStringDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: currentDate)
        return dateString
    }
    
    func futureDates(timeInterval : Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium

        return dateFormatter.string(from: date as Date)
    }
}

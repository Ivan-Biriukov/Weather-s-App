import UIKit
import CoreLocation

protocol HourlyWeatherManagerDelegate {
    
    func didUpdateWeather(weatherManager: HourlyWeatherManager,weather: DailyWeatherModel)
    func didFailWIthError(error: Error)
}

struct HourlyWeatherManager {

    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=\(K.apiKey)&units=metric"
    var delegate: HourlyWeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(longitude: CLLocationDegrees, latitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lon=\(longitude)&lat=\(latitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    self.delegate?.didFailWIthError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(weatherManager: self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> DailyWeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(HourlyWeatherData.self, from: weatherData)
            
            let city = decodedData.city.name
            let country = decodedData.city.country
            let sunrise = decodedData.city.sunrise
            let sunset = decodedData.city.sunset
            
            let timeIntervalsArray : [String] = ["00:00", "03:00", "06:00", "09:00", "12:00", "15:00", "18:00", "21:00"]
            
                                // First Day Section
            let firstDayHourlyTemp = [decodedData.list[0].main.temp, decodedData.list[1].main.temp, decodedData.list[2].main.temp, decodedData.list[3].main.temp, decodedData.list[4].main.temp, decodedData.list[5].main.temp, decodedData.list[6].main.temp, decodedData.list[7].main.temp]
            
            let firstDayHourlyFeelsTemps = [decodedData.list[0].main.feels_like, decodedData.list[1].main.feels_like, decodedData.list[2].main.feels_like, decodedData.list[3].main.feels_like, decodedData.list[4].main.feels_like, decodedData.list[5].main.feels_like, decodedData.list[6].main.feels_like, decodedData.list[7].main.feels_like]
            
            let firstDayMinTemps = [decodedData.list[0].main.temp_min, decodedData.list[1].main.temp_min, decodedData.list[2].main.temp_min, decodedData.list[3].main.temp_min, decodedData.list[4].main.temp_min, decodedData.list[5].main.temp_min, decodedData.list[6].main.temp_min, decodedData.list[7].main.temp_min]
            
            let firstDayMaxTemps = [decodedData.list[0].main.temp_max, decodedData.list[1].main.temp_max, decodedData.list[2].main.temp_max, decodedData.list[3].main.temp_max, decodedData.list[4].main.temp_max, decodedData.list[5].main.temp_max, decodedData.list[6].main.temp_max, decodedData.list[7].main.temp_max]
            
            let firstDayWinds = [decodedData.list[0].wind.speed, decodedData.list[1].wind.speed, decodedData.list[2].wind.speed, decodedData.list[3].wind.speed, decodedData.list[4].wind.speed, decodedData.list[5].wind.speed, decodedData.list[6].wind.speed, decodedData.list[7].wind.speed]
            
            let firstDayHumidityes = [decodedData.list[0].main.humidity,decodedData.list[1].main.humidity, decodedData.list[2].main.humidity, decodedData.list[3].main.humidity, decodedData.list[4].main.humidity, decodedData.list[5].main.humidity, decodedData.list[6].main.humidity, decodedData.list[7].main.humidity,]
            
            let firstDayHourlyWeatherName = [decodedData.list[0].weather[0].main, decodedData.list[1].weather[0].main, decodedData.list[2].weather[0].main, decodedData.list[3].weather[0].main, decodedData.list[4].weather[0].main, decodedData.list[5].weather[0].main, decodedData.list[6].weather[0].main, decodedData.list[7].weather[0].main]
            
            let firstDayVisibility = [decodedData.list[0].visibility,
                decodedData.list[1].visibility, decodedData.list[2].visibility, decodedData.list[3].visibility, decodedData.list[4].visibility, decodedData.list[5].visibility, decodedData.list[6].visibility, decodedData.list[7].visibility
            ]
            
            
            // Second Day Section
            let secondDayHourlyTemp = [decodedData.list[8].main.temp, decodedData.list[9].main.temp, decodedData.list[10].main.temp, decodedData.list[11].main.temp, decodedData.list[12].main.temp, decodedData.list[13].main.temp, decodedData.list[14].main.temp, decodedData.list[15].main.temp]
            
            let secondDayHourlyFeelsTemps = [decodedData.list[8].main.feels_like, decodedData.list[9].main.feels_like, decodedData.list[10].main.feels_like, decodedData.list[11].main.feels_like, decodedData.list[12].main.feels_like, decodedData.list[13].main.feels_like, decodedData.list[14].main.feels_like, decodedData.list[15].main.feels_like]
            
            let secondDayMinTemps = [decodedData.list[8].main.temp_min, decodedData.list[9].main.temp_min, decodedData.list[10].main.temp_min, decodedData.list[11].main.temp_min, decodedData.list[12].main.temp_min, decodedData.list[13].main.temp_min, decodedData.list[14].main.temp_min, decodedData.list[15].main.temp_min]
            
            let secondDayMaxTemps = [decodedData.list[8].main.temp_max, decodedData.list[9].main.temp_max, decodedData.list[10].main.temp_max, decodedData.list[11].main.temp_max, decodedData.list[12].main.temp_max, decodedData.list[13].main.temp_max, decodedData.list[14].main.temp_max, decodedData.list[15].main.temp_max]
            
            let secondDayWinds = [decodedData.list[8].wind.speed, decodedData.list[9].wind.speed, decodedData.list[10].wind.speed, decodedData.list[11].wind.speed, decodedData.list[12].wind.speed, decodedData.list[13].wind.speed, decodedData.list[14].wind.speed, decodedData.list[15].wind.speed]
            
            let secondDayHumidityes = [decodedData.list[8].main.humidity,decodedData.list[9].main.humidity, decodedData.list[10].main.humidity, decodedData.list[11].main.humidity, decodedData.list[12].main.humidity, decodedData.list[13].main.humidity, decodedData.list[14].main.humidity, decodedData.list[15].main.humidity,]
            
            let secondDayHourlyWeatherName = [decodedData.list[8].weather[0].main, decodedData.list[9].weather[0].main, decodedData.list[10].weather[0].main, decodedData.list[11].weather[0].main, decodedData.list[12].weather[0].main, decodedData.list[13].weather[0].main, decodedData.list[14].weather[0].main, decodedData.list[15].weather[0].main]
            
            let secondDayVisibility = [decodedData.list[8].visibility,
                decodedData.list[9].visibility, decodedData.list[10].visibility, decodedData.list[11].visibility, decodedData.list[12].visibility, decodedData.list[13].visibility, decodedData.list[14].visibility, decodedData.list[15].visibility
            ]
            
            
                        // Third Day Section
            let thirdDayHourlyTemp = [decodedData.list[16].main.temp, decodedData.list[17].main.temp, decodedData.list[18].main.temp, decodedData.list[19].main.temp, decodedData.list[20].main.temp, decodedData.list[21].main.temp, decodedData.list[22].main.temp, decodedData.list[23].main.temp]
            
            let thirdDayHourlyFeelsTemps = [decodedData.list[16].main.feels_like, decodedData.list[17].main.feels_like, decodedData.list[18].main.feels_like, decodedData.list[19].main.feels_like, decodedData.list[20].main.feels_like, decodedData.list[21].main.feels_like, decodedData.list[22].main.feels_like, decodedData.list[23].main.feels_like]
            
            let thirdDayMinTemps = [decodedData.list[16].main.temp_min, decodedData.list[17].main.temp_min, decodedData.list[18].main.temp_min, decodedData.list[19].main.temp_min, decodedData.list[20].main.temp_min, decodedData.list[21].main.temp_min, decodedData.list[22].main.temp_min, decodedData.list[23].main.temp_min]
            
            let thirdDayMaxTemps = [decodedData.list[16].main.temp_max, decodedData.list[17].main.temp_max, decodedData.list[18].main.temp_max, decodedData.list[19].main.temp_max, decodedData.list[20].main.temp_max, decodedData.list[21].main.temp_max, decodedData.list[22].main.temp_max, decodedData.list[23].main.temp_max]
            
            let thirdDayWinds = [decodedData.list[16].wind.speed, decodedData.list[17].wind.speed, decodedData.list[18].wind.speed, decodedData.list[19].wind.speed, decodedData.list[20].wind.speed, decodedData.list[21].wind.speed, decodedData.list[22].wind.speed, decodedData.list[23].wind.speed]
            
            let thirdDayHumidityes = [decodedData.list[16].main.humidity, decodedData.list[17].main.humidity, decodedData.list[18].main.humidity, decodedData.list[19].main.humidity, decodedData.list[20].main.humidity, decodedData.list[21].main.humidity, decodedData.list[22].main.humidity, decodedData.list[23].main.humidity,]
            
            let thirdDayHourlyWeatherName = [decodedData.list[16].weather[0].main, decodedData.list[17].weather[0].main, decodedData.list[18].weather[0].main, decodedData.list[19].weather[0].main, decodedData.list[20].weather[0].main, decodedData.list[21].weather[0].main, decodedData.list[22].weather[0].main, decodedData.list[23].weather[0].main]
            
            let thirdDayVisibility = [decodedData.list[16].visibility,
                decodedData.list[17].visibility, decodedData.list[18].visibility, decodedData.list[19].visibility, decodedData.list[20].visibility, decodedData.list[21].visibility, decodedData.list[22].visibility, decodedData.list[23].visibility
            ]
            
            
                        // Fourth Day Section
            let fourthDayHourlyTemp = [decodedData.list[24].main.temp, decodedData.list[25].main.temp, decodedData.list[26].main.temp, decodedData.list[27].main.temp, decodedData.list[28].main.temp, decodedData.list[29].main.temp, decodedData.list[30].main.temp, decodedData.list[31].main.temp]
            
            let fourthDayHourlyFeelsTemps = [decodedData.list[24].main.feels_like, decodedData.list[25].main.feels_like, decodedData.list[26].main.feels_like, decodedData.list[27].main.feels_like, decodedData.list[28].main.feels_like, decodedData.list[29].main.feels_like, decodedData.list[30].main.feels_like, decodedData.list[31].main.feels_like]
            
            let fourthDayMinTemps = [decodedData.list[24].main.temp_min, decodedData.list[25].main.temp_min, decodedData.list[26].main.temp_min, decodedData.list[27].main.temp_min, decodedData.list[28].main.temp_min, decodedData.list[29].main.temp_min, decodedData.list[30].main.temp_min, decodedData.list[31].main.temp_min]
            
            let fourthDayMaxTemps = [decodedData.list[24].main.temp_max, decodedData.list[25].main.temp_max, decodedData.list[26].main.temp_max, decodedData.list[27].main.temp_max, decodedData.list[28].main.temp_max, decodedData.list[29].main.temp_max, decodedData.list[30].main.temp_max, decodedData.list[31].main.temp_max]
            
            let fourthDayWinds = [decodedData.list[24].wind.speed, decodedData.list[25].wind.speed, decodedData.list[26].wind.speed, decodedData.list[27].wind.speed, decodedData.list[28].wind.speed, decodedData.list[29].wind.speed, decodedData.list[30].wind.speed, decodedData.list[31].wind.speed]
            
            let fourthDayHumidityes = [decodedData.list[24].main.humidity, decodedData.list[25].main.humidity, decodedData.list[26].main.humidity, decodedData.list[27].main.humidity, decodedData.list[28].main.humidity, decodedData.list[29].main.humidity, decodedData.list[30].main.humidity, decodedData.list[31].main.humidity]
            
            let fourthDayHourlyWeatherName = [decodedData.list[24].weather[0].main, decodedData.list[25].weather[0].main, decodedData.list[26].weather[0].main, decodedData.list[27].weather[0].main, decodedData.list[28].weather[0].main, decodedData.list[29].weather[0].main, decodedData.list[30].weather[0].main, decodedData.list[31].weather[0].main]
            
            let fourthDayVisibility = [decodedData.list[24].visibility,
                decodedData.list[25].visibility, decodedData.list[26].visibility, decodedData.list[27].visibility, decodedData.list[28].visibility, decodedData.list[29].visibility, decodedData.list[30].visibility, decodedData.list[31].visibility
            ]
            
            
                        // Last Day Section
            let lastDayHourlyTemp = [decodedData.list[32].main.temp, decodedData.list[33].main.temp, decodedData.list[34].main.temp, decodedData.list[35].main.temp, decodedData.list[36].main.temp, decodedData.list[37].main.temp, decodedData.list[38].main.temp, decodedData.list[39].main.temp]
            
            let lastDayHourlyFeelsTemps = [decodedData.list[32].main.feels_like, decodedData.list[33].main.feels_like, decodedData.list[34].main.feels_like, decodedData.list[35].main.feels_like, decodedData.list[36].main.feels_like, decodedData.list[37].main.feels_like, decodedData.list[38].main.feels_like, decodedData.list[39].main.feels_like]
            
            let lastDayMinTemps = [decodedData.list[32].main.temp_min, decodedData.list[33].main.temp_min, decodedData.list[34].main.temp_min, decodedData.list[35].main.temp_min, decodedData.list[36].main.temp_min, decodedData.list[37].main.temp_min, decodedData.list[38].main.temp_min, decodedData.list[39].main.temp_min]
            
            let lastDayMaxTemps = [decodedData.list[32].main.temp_max, decodedData.list[33].main.temp_max, decodedData.list[34].main.temp_max, decodedData.list[35].main.temp_max, decodedData.list[36].main.temp_max, decodedData.list[37].main.temp_max, decodedData.list[38].main.temp_max, decodedData.list[39].main.temp_max]
            
            let lastDayWinds = [decodedData.list[32].wind.speed, decodedData.list[33].wind.speed, decodedData.list[34].wind.speed, decodedData.list[35].wind.speed, decodedData.list[36].wind.speed, decodedData.list[37].wind.speed, decodedData.list[38].wind.speed, decodedData.list[39].wind.speed]
            
            let lastDayHumidityes = [decodedData.list[32].main.humidity, decodedData.list[33].main.humidity, decodedData.list[34].main.humidity, decodedData.list[35].main.humidity, decodedData.list[36].main.humidity, decodedData.list[37].main.humidity, decodedData.list[38].main.humidity, decodedData.list[39].main.humidity]
            
            let lstDayHourlyWeatherName = [decodedData.list[32].weather[0].main, decodedData.list[33].weather[0].main, decodedData.list[34].weather[0].main, decodedData.list[35].weather[0].main, decodedData.list[36].weather[0].main, decodedData.list[37].weather[0].main, decodedData.list[38].weather[0].main, decodedData.list[39].weather[0].main]
            
            let lastDayVisibility = [decodedData.list[32].visibility,
                decodedData.list[33].visibility, decodedData.list[34].visibility, decodedData.list[35].visibility, decodedData.list[36].visibility, decodedData.list[37].visibility, decodedData.list[38].visibility, decodedData.list[39].visibility
            ]
            
            
            
            let daysArray : [Days] = [
                .init(dayDate: decodedData.list[0].dt, timeIntervals: timeIntervalsArray, HourlyTemp: firstDayHourlyTemp, FeelsLikeHourleTemp: firstDayHourlyFeelsTemps, minHourlyTemp: firstDayMinTemps, maxHourlyTemp: firstDayMaxTemps, hourlyHumidityValues: firstDayHumidityes, hourlyWeatherConditionName: firstDayHourlyWeatherName, hourlyWindSpeed: firstDayWinds, visibiliti: firstDayVisibility),
                
                    .init(dayDate: decodedData.list[8].dt, timeIntervals: timeIntervalsArray, HourlyTemp: secondDayHourlyTemp, FeelsLikeHourleTemp: secondDayHourlyFeelsTemps, minHourlyTemp: secondDayMinTemps, maxHourlyTemp: secondDayMaxTemps, hourlyHumidityValues: secondDayHumidityes, hourlyWeatherConditionName: secondDayHourlyWeatherName, hourlyWindSpeed: secondDayWinds, visibiliti: secondDayVisibility),
                
                    .init(dayDate: decodedData.list[16].dt, timeIntervals: timeIntervalsArray, HourlyTemp: thirdDayHourlyTemp, FeelsLikeHourleTemp: thirdDayHourlyFeelsTemps, minHourlyTemp: thirdDayMinTemps, maxHourlyTemp: thirdDayMaxTemps, hourlyHumidityValues: thirdDayHumidityes, hourlyWeatherConditionName: thirdDayHourlyWeatherName, hourlyWindSpeed: thirdDayWinds, visibiliti: thirdDayVisibility),
                
                    .init(dayDate: decodedData.list[24].dt, timeIntervals: timeIntervalsArray, HourlyTemp: fourthDayHourlyTemp, FeelsLikeHourleTemp: fourthDayHourlyFeelsTemps, minHourlyTemp: fourthDayMinTemps, maxHourlyTemp: fourthDayMaxTemps, hourlyHumidityValues: fourthDayHumidityes, hourlyWeatherConditionName: fourthDayHourlyWeatherName, hourlyWindSpeed: fourthDayWinds, visibiliti: fourthDayVisibility),
                
                    .init(dayDate: decodedData.list[32].dt, timeIntervals: timeIntervalsArray, HourlyTemp: lastDayHourlyTemp, FeelsLikeHourleTemp: lastDayHourlyFeelsTemps, minHourlyTemp: lastDayMinTemps, maxHourlyTemp: lastDayMaxTemps, hourlyHumidityValues: lastDayHumidityes, hourlyWeatherConditionName: lstDayHourlyWeatherName, hourlyWindSpeed: lastDayWinds, visibiliti: lastDayVisibility)
            ]
            
            let population = decodedData.city.population
            
            let hourlyWeather = DailyWeatherModel(cityName: city, countryName: country, sunriseTime: sunrise, sunsetTime: sunset, population: population, days: daysArray)
         
            return hourlyWeather
            
        } catch {
                print(error)
            return nil
        }
    }
}

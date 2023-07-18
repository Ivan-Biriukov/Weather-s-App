import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(weatherManager: WeatherManager,weather: WeatherModel)
    func didFailWIthError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(K.apiKey)&units=metric"
    var delegate: WeatherManagerDelegate?
    
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
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do { 
            let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let feelsLikeTemp = decodedData.main.feels_like
            let tempMin = decodedData.main.temp_min
            let tempMax = decodedData.main.temp_max
            let humidity = decodedData.main.humidity
            let sunriseTime = decodedData.sys.sunrise
            let sunsetTime = decodedData.sys.sunset
            let cityName = decodedData.name
            let countryName = decodedData.sys.country
            let wind = decodedData.wind.speed
            let conditionName = decodedData.weather[0].main
            let pressure = decodedData.main.pressure
            
            let weather = WeatherModel(conditionId: id, conditionName: conditionName, countryName: countryName, cityName: cityName, temperature: temp, feelLikeTemp: feelsLikeTemp, minTemp: tempMin, maxTemp: tempMax, windSpeed: wind, humidity: humidity, sunrise: sunriseTime, sunset: sunsetTime, pressure: pressure)
            
            return weather
        } catch {
                print(error)
            return nil
        }
    }
}

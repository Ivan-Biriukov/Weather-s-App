import Foundation

struct WeatherData: Decodable { // Created struck to save incoming weather data. By applying :Decodable protocol we are saying that this struckt can now decording its self from external representation.
    let name: String
    let main: Main // so we make its qual way main.temp
    let weather: [Weather] // adopt way weather[0].description
    let wind: Wind // adopt way wind.speed
    let sys : Sys
}

struct Main: Decodable { // Create another struct becouse for property temp in our url we got that way: main.temp -> thats meants that main is an object with property temp
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
    let pressure: Int
}

struct Weather: Decodable { // Create another struct becouse for property discription in our url we got that way: weather[0].description ->
    let description: String
    let id: Int // Created Id properti to match it for change weather picture
    let main: String
}

struct Wind: Decodable { // Created extra struct for save an wind speed property from JSON
    let speed: Double
}

struct Sys: Decodable {
    let country: String
    let sunrise: Int
    let sunset: Int
}

// MARK: - Daily Weather Model for every 3 hours for 5 days

struct HourlyWeatherData: Decodable {
    let city : City
    let list : [List]
}

struct City: Decodable {
    let name : String
    let country : String
    let sunrise : Int
    let sunset : Int
    let population : Int
}

struct List: Decodable {
    let dt : Int
    let dt_txt : String
    let wind : Wind
    let weather : [Weather]
    let main : Main
    let visibility : Int
}

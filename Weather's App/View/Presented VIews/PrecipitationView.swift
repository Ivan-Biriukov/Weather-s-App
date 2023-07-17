import UIKit

class PrecipitationView: UIView {
    
    var hourlyWeatherManager = HourlyWeatherManager()
    
    var forecastTableCellsArray : [ForecastTableViewDataModel] = [
        .init(date: "today", time: "00-00", weatherImage: UIImage(systemName: "sun.max.trianglebadge.exclamationmark.fill")!, weatherConditionName: "Unknown", windSpeed: "0.0", minTemp: "0.0", maxTemp: "0.1", humiditi: "10%")
    ]
    
    var forecastFutureDaysArray : [ForecastTableViewDataModel] = []
    
    // MARK: - UI Elements
    
    private let mainTitleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold14()
        lb.textColor = .darkGrayText
        lb.textAlignment = .center
        lb.text = "Precipitation"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let precipitationCollectioView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 46, height: 200)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: 200).isActive = true
        c.showsHorizontalScrollIndicator = false
        c.backgroundColor = .clear
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private let  precipitationTableView : UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.layer.cornerRadius = 20
        table.backgroundColor = .additionalViewBackground
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
        configure()
        configureTableView()
        hourlyWeatherManager.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    // MARK: - Configure UI

    private func configureCollectionView() {
        precipitationCollectioView.delegate = self
        precipitationCollectioView.dataSource = self
        precipitationCollectioView.register(PrecipitationCollectioViewCell.self, forCellWithReuseIdentifier: "PrecipitationCollectioViewCell")
    }
    
    private func configureTableView() {
        precipitationTableView.delegate = self
        precipitationTableView.dataSource = self
        precipitationTableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: "precipitationTableViewCell")
    }
    
    private func configure() {
        addSubview(mainTitleLabel)
        addSubview(precipitationCollectioView)
        addSubview(precipitationTableView)
        
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            mainTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            precipitationCollectioView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 20),
            precipitationCollectioView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            precipitationCollectioView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            precipitationTableView.topAnchor.constraint(equalTo: precipitationCollectioView.bottomAnchor, constant: 20),
            precipitationTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            precipitationTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            precipitationTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - CollectionView Delegate & DataSource

extension PrecipitationView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = precipitationCollectioView.dequeueReusableCell(withReuseIdentifier: "PrecipitationCollectioViewCell", for: indexPath) as! PrecipitationCollectioViewCell
        
        return cell
    }
}

// MARK: - TableView Delegate & DataSource

extension PrecipitationView : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 100))
        
        let headerLabel : UILabel = {
            let lb = UILabel()
            lb.font = .poppinsRegular24()
            lb.textColor = .white
            lb.textAlignment = .center
            lb.translatesAutoresizingMaskIntoConstraints = false
            return lb
        }()
        
        header.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: header.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor)
        ])
        
        if section == 0 {
            headerLabel.text = "Today"
        } else {
            headerLabel.text = "Next 4 days"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return forecastTableCellsArray.count
        } else {
            return forecastFutureDaysArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = precipitationTableView.dequeueReusableCell(withIdentifier: "precipitationTableViewCell", for: indexPath) as! ForecastTableViewCell
        
        if indexPath.section == 0 {
            let curretnItem = forecastTableCellsArray[indexPath.row]
            cell.cellData = curretnItem
        } else {
            let curretnItem = forecastFutureDaysArray[indexPath.row]
            cell.cellData = curretnItem
        }
        
        return cell
    }
}

extension PrecipitationView: HourlyWeatherManagerDelegate {
    
    func didUpdateWeather(weatherManager: HourlyWeatherManager, weather: DailyWeatherModel) {
        
        DispatchQueue.main.async {
            self.forecastTableCellsArray = []
            self.forecastFutureDaysArray = []
            
                                        // First Day
            
            self.forecastTableCellsArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[0], weatherImage: weather.days[0].weatherImage(ElementNumber: 0), weatherConditionName: weather.days[0].hourlyWeatherConditionName[0], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[0].hourlyWindSpeed[0]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[0].minHourlyTemp[0]), maxTemp: weather.doubleToRoundedString(value: weather.days[0].maxHourlyTemp[0]), humiditi: "\(weather.days[0].hourlyHumidityValues[0])%"))
            
            self.forecastTableCellsArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[1], weatherImage: weather.days[0].weatherImage(ElementNumber: 1), weatherConditionName: weather.days[0].hourlyWeatherConditionName[1], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[0].hourlyWindSpeed[1]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[0].minHourlyTemp[1]), maxTemp: weather.doubleToRoundedString(value: weather.days[0].maxHourlyTemp[1]), humiditi: "\(weather.days[0].hourlyHumidityValues[1])%"))
            
            self.forecastTableCellsArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[2], weatherImage: weather.days[0].weatherImage(ElementNumber: 2), weatherConditionName: weather.days[0].hourlyWeatherConditionName[2], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[0].hourlyWindSpeed[2]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[0].minHourlyTemp[2]), maxTemp: weather.doubleToRoundedString(value: weather.days[0].maxHourlyTemp[2]), humiditi: "\(weather.days[0].hourlyHumidityValues[2])%"))
            
            self.forecastTableCellsArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[3], weatherImage: weather.days[0].weatherImage(ElementNumber: 3), weatherConditionName: weather.days[0].hourlyWeatherConditionName[3], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[0].hourlyWindSpeed[3]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[0].minHourlyTemp[3]), maxTemp: weather.doubleToRoundedString(value: weather.days[0].maxHourlyTemp[3]), humiditi: "\(weather.days[0].hourlyHumidityValues[3])%"))
            
            self.forecastTableCellsArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[4], weatherImage: weather.days[0].weatherImage(ElementNumber: 4), weatherConditionName: weather.days[0].hourlyWeatherConditionName[4], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[0].hourlyWindSpeed[4]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[0].minHourlyTemp[4]), maxTemp: weather.doubleToRoundedString(value: weather.days[0].maxHourlyTemp[4]), humiditi: "\(weather.days[0].hourlyHumidityValues[4])%"))
            
            self.forecastTableCellsArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[5], weatherImage: weather.days[0].weatherImage(ElementNumber: 5), weatherConditionName: weather.days[0].hourlyWeatherConditionName[5], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[0].hourlyWindSpeed[5]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[0].minHourlyTemp[5]), maxTemp: weather.doubleToRoundedString(value: weather.days[0].maxHourlyTemp[5]), humiditi: "\(weather.days[0].hourlyHumidityValues[5])%"))
            
            self.forecastTableCellsArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[6], weatherImage: weather.days[0].weatherImage(ElementNumber: 6), weatherConditionName: weather.days[0].hourlyWeatherConditionName[6], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[0].hourlyWindSpeed[6]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[0].minHourlyTemp[6]), maxTemp: weather.doubleToRoundedString(value: weather.days[0].maxHourlyTemp[6]), humiditi: "\(weather.days[0].hourlyHumidityValues[6])%"))
            
            self.forecastTableCellsArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[7], weatherImage: weather.days[0].weatherImage(ElementNumber: 7), weatherConditionName: weather.days[0].hourlyWeatherConditionName[7], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[0].hourlyWindSpeed[7]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[0].minHourlyTemp[7]), maxTemp: weather.doubleToRoundedString(value: weather.days[0].maxHourlyTemp[7]), humiditi: "\(weather.days[0].hourlyHumidityValues[7])%"))
            
                                    // Future Days
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[1].timeIntervals[0], weatherImage: weather.days[1].weatherImage(ElementNumber: 0), weatherConditionName: weather.days[1].hourlyWeatherConditionName[0], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[1].hourlyWindSpeed[0]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[1].minHourlyTemp[0]), maxTemp: weather.doubleToRoundedString(value: weather.days[1].maxHourlyTemp[0]), humiditi: "\(weather.days[1].hourlyHumidityValues[0])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[1].timeIntervals[1], weatherImage: weather.days[1].weatherImage(ElementNumber: 1), weatherConditionName: weather.days[1].hourlyWeatherConditionName[1], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[1].hourlyWindSpeed[1]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[1].minHourlyTemp[1]), maxTemp: weather.doubleToRoundedString(value: weather.days[1].maxHourlyTemp[1]), humiditi: "\(weather.days[1].hourlyHumidityValues[1])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[1].timeIntervals[2], weatherImage: weather.days[1].weatherImage(ElementNumber: 2), weatherConditionName: weather.days[1].hourlyWeatherConditionName[2], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[1].hourlyWindSpeed[2]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[1].minHourlyTemp[2]), maxTemp: weather.doubleToRoundedString(value: weather.days[1].maxHourlyTemp[2]), humiditi: "\(weather.days[1].hourlyHumidityValues[2])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[1].timeIntervals[3], weatherImage: weather.days[1].weatherImage(ElementNumber: 3), weatherConditionName: weather.days[1].hourlyWeatherConditionName[3], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[1].hourlyWindSpeed[3]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[1].minHourlyTemp[3]), maxTemp: weather.doubleToRoundedString(value: weather.days[1].maxHourlyTemp[3]), humiditi: "\(weather.days[1].hourlyHumidityValues[3])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[1].timeIntervals[4], weatherImage: weather.days[1].weatherImage(ElementNumber: 4), weatherConditionName: weather.days[1].hourlyWeatherConditionName[4], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[1].hourlyWindSpeed[4]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[1].minHourlyTemp[4]), maxTemp: weather.doubleToRoundedString(value: weather.days[1].maxHourlyTemp[4]), humiditi: "\(weather.days[1].hourlyHumidityValues[4])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[1].timeIntervals[5], weatherImage: weather.days[1].weatherImage(ElementNumber: 5), weatherConditionName: weather.days[1].hourlyWeatherConditionName[5], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[1].hourlyWindSpeed[5]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[1].minHourlyTemp[5]), maxTemp: weather.doubleToRoundedString(value: weather.days[1].maxHourlyTemp[5]), humiditi: "\(weather.days[1].hourlyHumidityValues[5])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[1].timeIntervals[6], weatherImage: weather.days[1].weatherImage(ElementNumber: 6), weatherConditionName: weather.days[1].hourlyWeatherConditionName[6], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[1].hourlyWindSpeed[6]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[1].minHourlyTemp[6]), maxTemp: weather.doubleToRoundedString(value: weather.days[1].maxHourlyTemp[6]), humiditi: "\(weather.days[1].hourlyHumidityValues[6])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[1].timeIntervals[7], weatherImage: weather.days[1].weatherImage(ElementNumber: 7), weatherConditionName: weather.days[1].hourlyWeatherConditionName[7], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[1].hourlyWindSpeed[7]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[1].minHourlyTemp[7]), maxTemp: weather.doubleToRoundedString(value: weather.days[1].maxHourlyTemp[7]), humiditi: "\(weather.days[1].hourlyHumidityValues[7])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[2].timeIntervals[0], weatherImage: weather.days[2].weatherImage(ElementNumber: 0), weatherConditionName: weather.days[2].hourlyWeatherConditionName[0], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[2].hourlyWindSpeed[0]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[2].minHourlyTemp[0]), maxTemp: weather.doubleToRoundedString(value: weather.days[2].maxHourlyTemp[0]), humiditi: "\(weather.days[2].hourlyHumidityValues[0])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[2].timeIntervals[1], weatherImage: weather.days[2].weatherImage(ElementNumber: 1), weatherConditionName: weather.days[2].hourlyWeatherConditionName[1], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[2].hourlyWindSpeed[1]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[2].minHourlyTemp[1]), maxTemp: weather.doubleToRoundedString(value: weather.days[2].maxHourlyTemp[1]), humiditi: "\(weather.days[2].hourlyHumidityValues[1])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[2].timeIntervals[3], weatherImage: weather.days[2].weatherImage(ElementNumber: 3), weatherConditionName: weather.days[2].hourlyWeatherConditionName[3], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[2].hourlyWindSpeed[3]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[2].minHourlyTemp[3]), maxTemp: weather.doubleToRoundedString(value: weather.days[2].maxHourlyTemp[3]), humiditi: "\(weather.days[2].hourlyHumidityValues[3])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[2].timeIntervals[4], weatherImage: weather.days[2].weatherImage(ElementNumber: 4), weatherConditionName: weather.days[2].hourlyWeatherConditionName[4], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[2].hourlyWindSpeed[4]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[2].minHourlyTemp[4]), maxTemp: weather.doubleToRoundedString(value: weather.days[2].maxHourlyTemp[4]), humiditi: "\(weather.days[2].hourlyHumidityValues[4])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[2].timeIntervals[5], weatherImage: weather.days[2].weatherImage(ElementNumber: 5), weatherConditionName: weather.days[2].hourlyWeatherConditionName[5], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[2].hourlyWindSpeed[5]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[2].minHourlyTemp[5]), maxTemp: weather.doubleToRoundedString(value: weather.days[2].maxHourlyTemp[5]), humiditi: "\(weather.days[2].hourlyHumidityValues[5])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[2].timeIntervals[6], weatherImage: weather.days[2].weatherImage(ElementNumber: 6), weatherConditionName: weather.days[2].hourlyWeatherConditionName[6], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[2].hourlyWindSpeed[6]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[2].minHourlyTemp[6]), maxTemp: weather.doubleToRoundedString(value: weather.days[2].maxHourlyTemp[6]), humiditi: "\(weather.days[2].hourlyHumidityValues[6])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[2].timeIntervals[7], weatherImage: weather.days[2].weatherImage(ElementNumber: 7), weatherConditionName: weather.days[2].hourlyWeatherConditionName[7], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[2].hourlyWindSpeed[7]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[2].minHourlyTemp[7]), maxTemp: weather.doubleToRoundedString(value: weather.days[2].maxHourlyTemp[7]), humiditi: "\(weather.days[2].hourlyHumidityValues[7])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[3].timeIntervals[0], weatherImage: weather.days[3].weatherImage(ElementNumber: 0), weatherConditionName: weather.days[3].hourlyWeatherConditionName[0], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[3].hourlyWindSpeed[0]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[3].minHourlyTemp[0]), maxTemp: weather.doubleToRoundedString(value: weather.days[3].maxHourlyTemp[0]), humiditi: "\(weather.days[3].hourlyHumidityValues[0])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[3].timeIntervals[1], weatherImage: weather.days[3].weatherImage(ElementNumber: 1), weatherConditionName: weather.days[3].hourlyWeatherConditionName[1], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[3].hourlyWindSpeed[1]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[3].minHourlyTemp[1]), maxTemp: weather.doubleToRoundedString(value: weather.days[3].maxHourlyTemp[1]), humiditi: "\(weather.days[3].hourlyHumidityValues[1])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[3].timeIntervals[2], weatherImage: weather.days[3].weatherImage(ElementNumber: 2), weatherConditionName: weather.days[3].hourlyWeatherConditionName[2], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[3].hourlyWindSpeed[2]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[3].minHourlyTemp[2]), maxTemp: weather.doubleToRoundedString(value: weather.days[3].maxHourlyTemp[2]), humiditi: "\(weather.days[3].hourlyHumidityValues[2])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[3].timeIntervals[3], weatherImage: weather.days[3].weatherImage(ElementNumber: 3), weatherConditionName: weather.days[3].hourlyWeatherConditionName[3], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[3].hourlyWindSpeed[3]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[3].minHourlyTemp[3]), maxTemp: weather.doubleToRoundedString(value: weather.days[3].maxHourlyTemp[3]), humiditi: "\(weather.days[3].hourlyHumidityValues[3])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[3].timeIntervals[4], weatherImage: weather.days[3].weatherImage(ElementNumber: 4), weatherConditionName: weather.days[3].hourlyWeatherConditionName[4], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[3].hourlyWindSpeed[4]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[3].minHourlyTemp[4]), maxTemp: weather.doubleToRoundedString(value: weather.days[3].maxHourlyTemp[4]), humiditi: "\(weather.days[3].hourlyHumidityValues[4])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[3].timeIntervals[5], weatherImage: weather.days[3].weatherImage(ElementNumber: 5), weatherConditionName: weather.days[3].hourlyWeatherConditionName[5], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[3].hourlyWindSpeed[5]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[3].minHourlyTemp[5]), maxTemp: weather.doubleToRoundedString(value: weather.days[3].maxHourlyTemp[5]), humiditi: "\(weather.days[3].hourlyHumidityValues[5])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[3].timeIntervals[6], weatherImage: weather.days[3].weatherImage(ElementNumber: 6), weatherConditionName: weather.days[3].hourlyWeatherConditionName[6], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[3].hourlyWindSpeed[6]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[3].minHourlyTemp[6]), maxTemp: weather.doubleToRoundedString(value: weather.days[3].maxHourlyTemp[6]), humiditi: "\(weather.days[3].hourlyHumidityValues[6])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[3].timeIntervals[7], weatherImage: weather.days[3].weatherImage(ElementNumber: 7), weatherConditionName: weather.days[3].hourlyWeatherConditionName[7], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[3].hourlyWindSpeed[7]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[3].minHourlyTemp[7]), maxTemp: weather.doubleToRoundedString(value: weather.days[3].maxHourlyTemp[7]), humiditi: "\(weather.days[3].hourlyHumidityValues[7])%"))
            
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[4].timeIntervals[0], weatherImage: weather.days[4].weatherImage(ElementNumber: 0), weatherConditionName: weather.days[4].hourlyWeatherConditionName[0], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[4].hourlyWindSpeed[0]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[4].minHourlyTemp[0]), maxTemp: weather.doubleToRoundedString(value: weather.days[4].maxHourlyTemp[0]), humiditi: "\(weather.days[4].hourlyHumidityValues[0])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[4].timeIntervals[1], weatherImage: weather.days[4].weatherImage(ElementNumber: 1), weatherConditionName: weather.days[4].hourlyWeatherConditionName[1], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[4].hourlyWindSpeed[1]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[4].minHourlyTemp[1]), maxTemp: weather.doubleToRoundedString(value: weather.days[4].maxHourlyTemp[1]), humiditi: "\(weather.days[4].hourlyHumidityValues[1])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[4].timeIntervals[2], weatherImage: weather.days[4].weatherImage(ElementNumber: 2), weatherConditionName: weather.days[4].hourlyWeatherConditionName[2], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[4].hourlyWindSpeed[2]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[4].minHourlyTemp[2]), maxTemp: weather.doubleToRoundedString(value: weather.days[4].maxHourlyTemp[2]), humiditi: "\(weather.days[4].hourlyHumidityValues[2])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[4].timeIntervals[3], weatherImage: weather.days[4].weatherImage(ElementNumber: 3), weatherConditionName: weather.days[4].hourlyWeatherConditionName[3], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[4].hourlyWindSpeed[3]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[4].minHourlyTemp[3]), maxTemp: weather.doubleToRoundedString(value: weather.days[4].maxHourlyTemp[3]), humiditi: "\(weather.days[4].hourlyHumidityValues[3])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[4].timeIntervals[4], weatherImage: weather.days[4].weatherImage(ElementNumber: 4), weatherConditionName: weather.days[4].hourlyWeatherConditionName[4], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[4].hourlyWindSpeed[4]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[4].minHourlyTemp[4]), maxTemp: weather.doubleToRoundedString(value: weather.days[4].maxHourlyTemp[4]), humiditi: "\(weather.days[4].hourlyHumidityValues[4])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[4].timeIntervals[5], weatherImage: weather.days[4].weatherImage(ElementNumber: 5), weatherConditionName: weather.days[4].hourlyWeatherConditionName[5], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[4].hourlyWindSpeed[5]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[4].minHourlyTemp[5]), maxTemp: weather.doubleToRoundedString(value: weather.days[4].maxHourlyTemp[5]), humiditi: "\(weather.days[4].hourlyHumidityValues[5])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[4].timeIntervals[6], weatherImage: weather.days[4].weatherImage(ElementNumber: 6), weatherConditionName: weather.days[4].hourlyWeatherConditionName[6], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[4].hourlyWindSpeed[6]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[4].minHourlyTemp[6]), maxTemp: weather.doubleToRoundedString(value: weather.days[4].maxHourlyTemp[6]), humiditi: "\(weather.days[4].hourlyHumidityValues[6])%"))
            
            self.forecastFutureDaysArray.append(ForecastTableViewDataModel(date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[4].timeIntervals[7], weatherImage: weather.days[4].weatherImage(ElementNumber: 7), weatherConditionName: weather.days[4].hourlyWeatherConditionName[7], windSpeed: "wind - " + weather.doubleToRoundedString(value: weather.days[4].hourlyWindSpeed[7]) + " m/s", minTemp: weather.doubleToRoundedString(value: weather.days[4].minHourlyTemp[7]), maxTemp: weather.doubleToRoundedString(value: weather.days[4].maxHourlyTemp[7]), humiditi: "\(weather.days[4].hourlyHumidityValues[7])%"))
            
            self.precipitationTableView.reloadData()
        }
    }
    
    func didFailWIthError(error: Error) {
        print(error)
    }
    
    
}

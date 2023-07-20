import UIKit

class ForecastView: UIView {
    
    var hourlyWeatherManager = HourlyWeatherManager()
    
    private var sectionNamesArray : [String] = ["Today", "Future"]
    
    var sectionNameValue = 0
    var countofTableResults = 7
    
    var forecastWheaterCollectionDataArray : [ForecastColletionDataModel] = [
        .init(conditionImg: UIImage(systemName: "sun.max.trianglebadge.exclamationmark.fill")!, date: "00.00", time: "00:00", temp: "0"),
        .init(conditionImg: UIImage(systemName: "sun.max.trianglebadge.exclamationmark.fill")!, date: "00.00", time: "00:00", temp: "0"),
        .init(conditionImg: UIImage(systemName: "sun.max.trianglebadge.exclamationmark.fill")!, date: "00.00", time: "00:00", temp: "0"),
    ]
    
    var forecastTableCellsArray : [ForecastTableViewDataModel] = [
        .init(date: "today", time: "00-00", weatherImage: UIImage(systemName: "sun.max.trianglebadge.exclamationmark.fill")!, weatherConditionName: "Unknown", windSpeed: "0.0", minTemp: "0.0", maxTemp: "0.1", humiditi: "10%")
    ]
    
    var forecastFutureDaysArray : [ForecastTableViewDataModel] = []

    // MARK: - UI Elements
    
    private let forecastCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 46, height: 100)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: 110).isActive = true
        c.showsHorizontalScrollIndicator = false
        c.backgroundColor = .clear
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private lazy var todayButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Today", for: .normal)
        btn.titleLabel?.font = .poppinsMedium12()
        btn.addTarget(self, action: #selector(nextWeekButtonTaped), for: .touchUpInside)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private lazy var futureDaysButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Next Days", for: .normal)
        btn.titleLabel?.font = .poppinsMedium12()
        btn.addTarget(self, action: #selector(nextTwoWeeksButtonTaped), for: .touchUpInside)
        btn.setTitleColor(.lightGrayText, for: .normal)
        return btn
    }()
    
    private let separateVerticalLine : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGrayText
        view.heightAnchor.constraint(equalToConstant: 14).isActive = true
        view.widthAnchor.constraint(equalToConstant: 2).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let periodStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let forecastTableView : UITableView = {
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
        addSubviews()
        setupConstraints()
        configureCollectionView()
        configureTableView()
        hourlyWeatherManager.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    
    // MARK: - Buttons Methods
    
    @objc func nextWeekButtonTaped() {
        todayButton.setTitleColor(.white, for: .normal)
        futureDaysButton.setTitleColor(.lightGrayText, for: .normal)
        
        DispatchQueue.main.async {
            self.forecastTableView.reloadData()
            self.forecastTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    @objc func nextTwoWeeksButtonTaped() {
        futureDaysButton.setTitleColor(.white, for: .normal)
        todayButton.setTitleColor(.lightGrayText, for: .normal)
       DispatchQueue.main.async {
           self.forecastTableView.reloadData()
           self.forecastTableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
       }
    }

    
    // MARK: - Configure UI
    
    private func addSubviews() {
       addSubview(forecastCollectionView)
        addSubview(periodStack)
        periodStack.addArrangedSubview(todayButton)
        periodStack.addArrangedSubview(separateVerticalLine)
        periodStack.addArrangedSubview(futureDaysButton)
        addSubview(forecastTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            forecastCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            forecastCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            forecastCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            periodStack.topAnchor.constraint(equalTo: forecastCollectionView.bottomAnchor, constant: 20),
            periodStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            forecastTableView.topAnchor.constraint(equalTo: periodStack.bottomAnchor, constant: 25),
            forecastTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            forecastTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            forecastTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func configureCollectionView() {
        forecastCollectionView.delegate = self
        forecastCollectionView.dataSource = self
        forecastCollectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: "ForecastCollectionViewCell")
    }
    
    private func configureTableView() {
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        forecastTableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: "ForecastTableViewCell")
    }
}

// MARK: - CollectionView Delegate & DataSource

extension ForecastView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastWheaterCollectionDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = forecastCollectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionViewCell", for: indexPath) as! ForecastCollectionViewCell
        
        let currentItem = forecastWheaterCollectionDataArray[indexPath.row]
        cell.cellData = currentItem
        
        return cell
    }
}

// MARK: - TableView Delegate & DataSource

extension ForecastView: UITableViewDelegate, UITableViewDataSource {
    
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
            headerLabel.text = sectionNamesArray[0]
        } else {
            headerLabel.text = sectionNamesArray[1]
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
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        
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

// MARK: - HourlyWeather Delegate

extension ForecastView: HourlyWeatherManagerDelegate {
    
    func didUpdateWeather(weatherManager: HourlyWeatherManager, weather: DailyWeatherModel) {
        
        DispatchQueue.main.async {
            self.forecastWheaterCollectionDataArray = []
            
                            // first Day
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[0].weatherImage(ElementNumber: 0), date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[0], temp: weather.doubleToRoundedString(value: weather.days[0].HourlyTemp[0])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[0].weatherImage(ElementNumber: 1), date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[1], temp: weather.doubleToRoundedString(value: weather.days[0].HourlyTemp[1])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[0].weatherImage(ElementNumber: 2), date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[2], temp: weather.doubleToRoundedString(value: weather.days[0].HourlyTemp[2])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[0].weatherImage(ElementNumber: 3), date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[3], temp: weather.doubleToRoundedString(value: weather.days[0].HourlyTemp[3])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[0].weatherImage(ElementNumber: 4), date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[4], temp: weather.doubleToRoundedString(value: weather.days[0].HourlyTemp[4])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[0].weatherImage(ElementNumber: 5), date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[5], temp: weather.doubleToRoundedString(value: weather.days[0].HourlyTemp[5])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[0].weatherImage(ElementNumber: 6), date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[6], temp: weather.doubleToRoundedString(value: weather.days[0].HourlyTemp[6])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[0].weatherImage(ElementNumber: 7), date: weather.futureSHortDates(timeInterval: weather.days[0].dayDate), time: weather.days[0].timeIntervals[7], temp: weather.doubleToRoundedString(value: weather.days[0].HourlyTemp[7])))
            
                            // Second Day
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[1].weatherImage(ElementNumber: 0), date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[0].timeIntervals[0], temp: weather.doubleToRoundedString(value: weather.days[1].HourlyTemp[0])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[1].weatherImage(ElementNumber: 1), date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[0].timeIntervals[1], temp: weather.doubleToRoundedString(value: weather.days[1].HourlyTemp[1])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[1].weatherImage(ElementNumber: 2), date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[0].timeIntervals[2], temp: weather.doubleToRoundedString(value: weather.days[1].HourlyTemp[2])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[1].weatherImage(ElementNumber: 3), date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[0].timeIntervals[3], temp: weather.doubleToRoundedString(value: weather.days[1].HourlyTemp[3])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[1].weatherImage(ElementNumber: 4), date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[0].timeIntervals[4], temp: weather.doubleToRoundedString(value: weather.days[1].HourlyTemp[4])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[1].weatherImage(ElementNumber: 5), date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[0].timeIntervals[5], temp: weather.doubleToRoundedString(value: weather.days[1].HourlyTemp[5])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[1].weatherImage(ElementNumber: 6), date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[0].timeIntervals[6], temp: weather.doubleToRoundedString(value: weather.days[1].HourlyTemp[6])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[1].weatherImage(ElementNumber: 7), date: weather.futureSHortDates(timeInterval: weather.days[1].dayDate), time: weather.days[0].timeIntervals[7], temp: weather.doubleToRoundedString(value: weather.days[1].HourlyTemp[7])))
            
                                    // thirdDay
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[2].weatherImage(ElementNumber: 0), date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[0].timeIntervals[0], temp: weather.doubleToRoundedString(value: weather.days[2].HourlyTemp[0])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[2].weatherImage(ElementNumber: 1), date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[0].timeIntervals[1], temp: weather.doubleToRoundedString(value: weather.days[2].HourlyTemp[1])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[2].weatherImage(ElementNumber: 2), date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[0].timeIntervals[2], temp: weather.doubleToRoundedString(value: weather.days[2].HourlyTemp[2])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[2].weatherImage(ElementNumber: 3), date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[0].timeIntervals[3], temp: weather.doubleToRoundedString(value: weather.days[2].HourlyTemp[3])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[2].weatherImage(ElementNumber: 4), date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[0].timeIntervals[4], temp: weather.doubleToRoundedString(value: weather.days[2].HourlyTemp[4])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[2].weatherImage(ElementNumber: 5), date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[0].timeIntervals[5], temp: weather.doubleToRoundedString(value: weather.days[2].HourlyTemp[5])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[2].weatherImage(ElementNumber: 6), date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[0].timeIntervals[6], temp: weather.doubleToRoundedString(value: weather.days[2].HourlyTemp[6])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[2].weatherImage(ElementNumber: 7), date: weather.futureSHortDates(timeInterval: weather.days[2].dayDate), time: weather.days[0].timeIntervals[7], temp: weather.doubleToRoundedString(value: weather.days[2].HourlyTemp[7])))
            
                                // Fourth Day
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[3].weatherImage(ElementNumber: 0), date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[0].timeIntervals[0], temp: weather.doubleToRoundedString(value: weather.days[3].HourlyTemp[0])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[3].weatherImage(ElementNumber: 1), date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[0].timeIntervals[1], temp: weather.doubleToRoundedString(value: weather.days[3].HourlyTemp[1])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[3].weatherImage(ElementNumber: 2), date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[0].timeIntervals[2], temp: weather.doubleToRoundedString(value: weather.days[3].HourlyTemp[2])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[3].weatherImage(ElementNumber: 3), date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[0].timeIntervals[3], temp: weather.doubleToRoundedString(value: weather.days[3].HourlyTemp[3])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[3].weatherImage(ElementNumber: 4), date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[0].timeIntervals[4], temp: weather.doubleToRoundedString(value: weather.days[3].HourlyTemp[4])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[3].weatherImage(ElementNumber: 5), date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[0].timeIntervals[5], temp: weather.doubleToRoundedString(value: weather.days[3].HourlyTemp[5])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[3].weatherImage(ElementNumber: 6), date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[0].timeIntervals[6], temp: weather.doubleToRoundedString(value: weather.days[3].HourlyTemp[6])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[3].weatherImage(ElementNumber: 7), date: weather.futureSHortDates(timeInterval: weather.days[3].dayDate), time: weather.days[0].timeIntervals[7], temp: weather.doubleToRoundedString(value: weather.days[3].HourlyTemp[7])))
            
                                // Last Day
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[4].weatherImage(ElementNumber: 0), date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[0].timeIntervals[0], temp: weather.doubleToRoundedString(value: weather.days[4].HourlyTemp[0])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[4].weatherImage(ElementNumber: 1), date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[0].timeIntervals[1], temp: weather.doubleToRoundedString(value: weather.days[4].HourlyTemp[1])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[4].weatherImage(ElementNumber: 2), date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[0].timeIntervals[2], temp: weather.doubleToRoundedString(value: weather.days[4].HourlyTemp[2])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[4].weatherImage(ElementNumber: 3), date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[0].timeIntervals[3], temp: weather.doubleToRoundedString(value: weather.days[4].HourlyTemp[3])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[4].weatherImage(ElementNumber: 4), date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[0].timeIntervals[4], temp: weather.doubleToRoundedString(value: weather.days[4].HourlyTemp[4])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[4].weatherImage(ElementNumber: 5), date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[0].timeIntervals[5], temp: weather.doubleToRoundedString(value: weather.days[4].HourlyTemp[5])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[4].weatherImage(ElementNumber: 6), date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[0].timeIntervals[6], temp: weather.doubleToRoundedString(value: weather.days[4].HourlyTemp[6])))
            
            self.forecastWheaterCollectionDataArray.append(ForecastColletionDataModel(conditionImg: weather.days[4].weatherImage(ElementNumber: 7), date: weather.futureSHortDates(timeInterval: weather.days[4].dayDate), time: weather.days[0].timeIntervals[7], temp: weather.doubleToRoundedString(value: weather.days[4].HourlyTemp[7])))
            
            self.forecastCollectionView.reloadData()
            
            
            // TableView Data SetUP
            
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
            self.forecastTableView.reloadData()
        }
    }
    
    func didFailWIthError(error: Error) {
        print(error)
    }
    
    
}

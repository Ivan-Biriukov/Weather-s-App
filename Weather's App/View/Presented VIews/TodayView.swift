import UIKit

class TodayView: UIView {
    
    // MARK: - UI Elements
    
                                        // Header Section
    
    private let dateBubleView : UIView = {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: 180).isActive = true
        view.heightAnchor.constraint(equalToConstant: 35).isActive = true
        view.layer.cornerRadius = 16
        view.backgroundColor = .customViewsUnselectedBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textAlignment = .center
        lb.textColor = .darkGrayText
        lb.text = "Saturday, 11 Sept"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let wheaterImageView : UIImageView = {
        let img = UIImageView()
        img.widthAnchor.constraint(equalToConstant: 120).isActive = true
        img.heightAnchor.constraint(equalToConstant: 120).isActive = true
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: K.WheatherConditionsImages.clouds)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let tempValueLabel : GradientLabel = {
        let lb = GradientLabel()
        lb.font = .poppinsTemp()
        lb.text = "33°"
        lb.gradientColors = [UIColor.lightGrayText.cgColor, UIColor.darkGrayText.cgColor]
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let weatherShortDescriptionLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textAlignment = .center
        lb.textColor = .white
        lb.text = "Partly cloudy"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let temperatureStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let firstLineStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let dailyMiddleTempLabel: UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let separateVerticalLine : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrayText
        view.heightAnchor.constraint(equalToConstant: 14).isActive = true
        view.widthAnchor.constraint(equalToConstant: 2).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let windSpeedLabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let secondLineStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
                                        // Middle Section
    
    private let probabilityOfPrecipitationImage : UIImageView = {
        let img = UIImageView(image: UIImage(named: K.TodayView.precipitationPosibilityImg))
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 16).isActive = true
        img.widthAnchor.constraint(equalToConstant: 20).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let probabilityOfPrecipitationLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let precipitationStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 11
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let humidityImg : UIImageView = {
        let img = UIImageView(image: UIImage(named: K.TodayView.humidityImg))
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 16).isActive = true
        img.widthAnchor.constraint(equalToConstant: 20).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let humidityLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let humidityStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 11
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let firstGroupStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let windImg : UIImageView = {
        let img = UIImageView(image: UIImage(named: K.TodayView.windImg))
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 16).isActive = true
        img.widthAnchor.constraint(equalToConstant: 20).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let windLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let windStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 11
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let sunsetImg : UIImageView = {
        let img = UIImageView(image: UIImage(named: K.TodayView.sunsetImg))
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 16).isActive = true
        img.widthAnchor.constraint(equalToConstant: 20).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let sunsetLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let sunsetStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 11
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let secondGroupStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let hourlyWheaterCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 46, height: 100)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.heightAnchor.constraint(equalToConstant: 100).isActive = true
        c.showsHorizontalScrollIndicator = false
        c.backgroundColor = .clear
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
                                // Daily Temp Table Section
    
    private let dailyTepmTable : UITableView = {
        let table = UITableView()
        table.backgroundColor = .additionalViewBackground
        table.translatesAutoresizingMaskIntoConstraints = false
        table.clipsToBounds = false
        table.layer.masksToBounds = false
        table.layer.shadowColor = UIColor.white.cgColor
        table.layer.shadowOffset = CGSize(width: 0, height: 5)
        table.layer.shadowRadius = 5.0
        table.layer.shadowOpacity = 0.5
        table.layer.cornerRadius = 10
        return table
    }()
    
    
                                // Details Section
    
    private let detailsContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .additionalViewBackground
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let detailMainTitle : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold14()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Details"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailWeatherConditionImg : UIImageView = {
        let img = UIImageView(image: UIImage(named: K.WheatherConditionsImages.clouds))
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 65).isActive = true
        img.widthAnchor.constraint(equalToConstant: 80).isActive = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let detailFeelsLikeLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textColor = .lightGrayText
        lb.textAlignment = .center
        lb.text = "Feels like"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailFeelsLikeValueLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsMedium12()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "76°"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailsFirstLaneStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 35
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let detailHumidityLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textColor = .lightGrayText
        lb.textAlignment = .center
        lb.text = "Humidity"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailHumidityValueLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsMedium12()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "63%"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailsSecondLaneStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 35
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let detailVisibilityLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textColor = .lightGrayText
        lb.textAlignment = .center
        lb.text = "Visibility"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailVisibilityValueLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsMedium12()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "10 mi"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailsThirdLaneStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 35
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let detailUVIndexLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textColor = .lightGrayText
        lb.textAlignment = .center
        lb.text = "UV Index"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailUVIndexValueLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsMedium12()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Low 0"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailsFourthLaneStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 35
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    private let detailDewpointLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular12()
        lb.textColor = .lightGrayText
        lb.textAlignment = .center
        lb.text = "Dew point"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailDewpointValueLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsMedium12()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "56°"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let detailsFifthLaneStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 35
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let detailsMainRightStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let detailDescriptionLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular10()
        lb.textColor = .lightGrayText
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.text = "Tonight - Clear. Winds from SW to SSW at 10 to 11 mph (16.1 to 17.7 kph). The overnight low will be 69° F (20.0 ° C)"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
                                    // Air Quelity Section
    
    private let airQuelityContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .additionalViewBackground
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let airQuelityMainTitle : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold14()
        lb.textColor = .white
        lb.textAlignment = .left
        lb.text = "Air Quality"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var airQuelityInfoButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "info.circle"), for: .normal)
        btn.tintColor = .white
        btn.heightAnchor.constraint(equalToConstant: 16).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 16).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let airQuelityTitleStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let airQuelityProgressView = CircularProgressView()
    
    private let airQuelityComentLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsLight10()
        lb.textColor = .lightGrayText
        lb.textAlignment = .left
        lb.text = "You have good air quality - enjoy your outdoor activities."
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        conffigure()
        setupConstraints()
        setupDifferentColorsForLabels()
        addDashedBorder(startX: 15, startY: 220, endX: Int(self.bounds.width) - 20, endY: 220)
        setupCollection()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure Section
    
    private func conffigure() {
        addSubview(dateBubleView)
        dateBubleView.addSubview(dateLabel)
        addSubview(firstLineStack)
        firstLineStack.addArrangedSubview(wheaterImageView)
        firstLineStack.addArrangedSubview(temperatureStack)
        temperatureStack.addArrangedSubview(tempValueLabel)
        temperatureStack.addArrangedSubview(weatherShortDescriptionLabel)
        addSubview(secondLineStack)
        secondLineStack.addArrangedSubview(dailyMiddleTempLabel)
        secondLineStack.addArrangedSubview(separateVerticalLine)
        secondLineStack.addArrangedSubview(windSpeedLabel)
        addSubview(firstGroupStack)
        firstGroupStack.addArrangedSubview(precipitationStack)
        precipitationStack.addArrangedSubview(probabilityOfPrecipitationImage)
        precipitationStack.addArrangedSubview(probabilityOfPrecipitationLabel)
        firstGroupStack.addArrangedSubview(humidityStack)
        humidityStack.addArrangedSubview(humidityImg)
        humidityStack.addArrangedSubview(humidityLabel)
        addSubview(secondGroupStack)
        secondGroupStack.addArrangedSubview(windStack)
        windStack.addArrangedSubview(windImg)
        windStack.addArrangedSubview(windLabel)
        secondGroupStack.addArrangedSubview(sunsetStack)
        sunsetStack.addArrangedSubview(sunsetImg)
        sunsetStack.addArrangedSubview(sunsetLabel)
        addSubview(hourlyWheaterCollection)
        addSubview(dailyTepmTable)
        addSubview(detailsContainer)
        detailsContainer.addSubview(detailMainTitle)
        detailsContainer.addSubview(detailWeatherConditionImg)
        detailsContainer.addSubview(detailsMainRightStack)
        detailsMainRightStack.addArrangedSubview(detailsFirstLaneStack)
        detailsFirstLaneStack.addArrangedSubview(detailFeelsLikeLabel)
        detailsFirstLaneStack.addArrangedSubview(detailFeelsLikeValueLabel)
        detailsMainRightStack.addArrangedSubview(detailsSecondLaneStack)
        detailsSecondLaneStack.addArrangedSubview(detailHumidityLabel)
        detailsSecondLaneStack.addArrangedSubview(detailHumidityValueLabel)
        detailsMainRightStack.addArrangedSubview(detailsThirdLaneStack)
        detailsThirdLaneStack.addArrangedSubview(detailVisibilityLabel)
        detailsThirdLaneStack.addArrangedSubview(detailVisibilityValueLabel)
        detailsMainRightStack.addArrangedSubview(detailsFourthLaneStack)
        detailsFourthLaneStack.addArrangedSubview(detailUVIndexLabel)
        detailsFourthLaneStack.addArrangedSubview(detailUVIndexValueLabel)
        detailsMainRightStack.addArrangedSubview(detailsFifthLaneStack)
        detailsFifthLaneStack.addArrangedSubview(detailDewpointLabel)
        detailsFifthLaneStack.addArrangedSubview(detailDewpointValueLabel)
        detailsContainer.addSubview(detailDescriptionLabel)

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: dateBubleView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: dateBubleView.centerYAnchor),
            
            dateBubleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateBubleView.topAnchor.constraint(equalTo: topAnchor),
            
            firstLineStack.topAnchor.constraint(equalTo: dateBubleView.bottomAnchor, constant: 10),
            firstLineStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            firstLineStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -55),
            
            secondLineStack.topAnchor.constraint(equalTo: firstLineStack.bottomAnchor, constant: 15),
            secondLineStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            secondLineStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            firstGroupStack.topAnchor.constraint(equalTo: secondLineStack.bottomAnchor, constant: 45),
            firstGroupStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            firstGroupStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -55),
            
            secondGroupStack.topAnchor.constraint(equalTo: firstGroupStack.bottomAnchor, constant: 12),
            secondGroupStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            secondGroupStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -55),
            
            hourlyWheaterCollection.topAnchor.constraint(equalTo: secondGroupStack.bottomAnchor, constant: 28),
            hourlyWheaterCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            hourlyWheaterCollection.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            
            dailyTepmTable.topAnchor.constraint(equalTo: hourlyWheaterCollection.bottomAnchor, constant: 30),
            dailyTepmTable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dailyTepmTable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            dailyTepmTable.heightAnchor.constraint(equalToConstant: 320),
            
            detailsContainer.topAnchor.constraint(equalTo: dailyTepmTable.bottomAnchor, constant: 20),
            detailsContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            detailsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            detailsContainer.heightAnchor.constraint(equalToConstant: 300),
            
            detailMainTitle.topAnchor.constraint(equalTo: detailsContainer.topAnchor, constant: 10),
            detailMainTitle.leadingAnchor.constraint(equalTo: detailsContainer.leadingAnchor, constant: 22),
            
            detailWeatherConditionImg.topAnchor.constraint(equalTo: detailMainTitle.bottomAnchor, constant: 32),
            detailWeatherConditionImg.leadingAnchor.constraint(equalTo: detailsContainer.leadingAnchor, constant: 22),
            detailsMainRightStack.topAnchor.constraint(equalTo: detailsContainer.topAnchor, constant: 36),
            detailsMainRightStack.leadingAnchor.constraint(equalTo: detailWeatherConditionImg.trailingAnchor, constant: 70),
            detailsMainRightStack.trailingAnchor.constraint(equalTo: detailsContainer.trailingAnchor, constant: -25),
            
            detailDescriptionLabel.leadingAnchor.constraint(equalTo: detailsContainer.leadingAnchor, constant: 25),
            detailDescriptionLabel.trailingAnchor.constraint(equalTo: detailsContainer.trailingAnchor, constant: -25),
            detailDescriptionLabel.topAnchor.constraint(equalTo: detailsMainRightStack.bottomAnchor, constant: 40),
        ])
    }
    
    private func setupDifferentColorsForLabels() {
        feelsLikeAtributtedString(forLAbel: dailyMiddleTempLabel, grayText: "29°/27° | Feels like ", whiteText: "39°C")
        feelsLikeAtributtedString(forLAbel: windSpeedLabel, grayText: "Wind speed ", whiteText: "9 KM/H")
        feelsLikeAtributtedString(forLAbel: probabilityOfPrecipitationLabel, grayText: "Precipitation: ", whiteText: "21%")
        feelsLikeAtributtedString(forLAbel: humidityLabel, grayText: "Humidity: ", whiteText: "59%")
        feelsLikeAtributtedString(forLAbel: windLabel, grayText: "Wind: ", whiteText: "10 km/h")
        feelsLikeAtributtedString(forLAbel: sunsetLabel, grayText: "Sunset: ", whiteText: "18:34")
    }
    
    private func setupCollection() {
        hourlyWheaterCollection.delegate = self
        hourlyWheaterCollection.dataSource = self
        hourlyWheaterCollection.register(WheaterHourlyCollectionViewCell.self, forCellWithReuseIdentifier: "HourleWheaterCell")
    }
    
    private func setupTableView() {
        dailyTepmTable.delegate = self
        dailyTepmTable.dataSource = self
        dailyTepmTable.register(DailyWeatherTableViewCell.self, forCellReuseIdentifier: "dailyTempTableCell")
        dailyTepmTable.register(DailyWeatherTableViewFirstIndexCell.self, forCellReuseIdentifier: "firstIndexCell")
    }
}
    

// MARK: - Collection Delegate & DataSource

extension TodayView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourleWheaterCell", for: indexPath) as! WheaterHourlyCollectionViewCell
        
        return cell
    }
}

// MARK: - TableView Delegate & DataSource

extension TodayView : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = dailyTepmTable.dequeueReusableCell(withIdentifier: "firstIndexCell", for: indexPath)
            cell.selectionStyle = .none
            return cell
        } else {
            
            let cell = dailyTepmTable.dequeueReusableCell(withIdentifier: "dailyTempTableCell", for: indexPath) as! DailyWeatherTableViewCell
            cell.selectionStyle = .none
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}


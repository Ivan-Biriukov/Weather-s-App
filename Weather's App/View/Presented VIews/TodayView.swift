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
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        conffigure()
        setupConstraints()
        setupDifferentColorsForLabels()
        addDashedBorder(startX: 15, startY: 220, endX: Int(self.bounds.width) - 20, endY: 220)
        setupCollection()
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


import UIKit

class ForecastView: UIView {
    
    private var sectionNamesArray : [String] = ["This Week", "Next Week", "This Mounth"]

    // MARK: - UI Elements
    
    private let forecastCollectionView : UICollectionView = {
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
    
    private lazy var nextWeekButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Next Week", for: .normal)
        btn.titleLabel?.font = .poppinsMedium12()
        btn.addTarget(self, action: #selector(nextWeekButtonTaped), for: .touchUpInside)
        btn.setTitleColor(.lightGrayText, for: .normal)
        return btn
    }()
    
    private lazy var nextTwoWeeksButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Next Two Weeks", for: .normal)
        btn.titleLabel?.font = .poppinsMedium12()
        btn.addTarget(self, action: #selector(nextTwoWeeksButtonTaped), for: .touchUpInside)
        btn.setTitleColor(.lightGrayText, for: .normal)
        return btn
    }()
    
    private lazy var nextMonthButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("For a Month", for: .normal)
        btn.titleLabel?.font = .poppinsMedium12()
        btn.addTarget(self, action: #selector(nextMonthButtonTaped), for: .touchUpInside)
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
    
    private let secondSeparateLine : UIView = {
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    
    // MARK: - Buttons Methods
    
    @objc func nextWeekButtonTaped() {}
    
    @objc func nextTwoWeeksButtonTaped() {}
    
    @objc func nextMonthButtonTaped() {}
    
    // MARK: - Configure UI
    
    private func addSubviews() {
       addSubview(forecastCollectionView)
        addSubview(periodStack)
        periodStack.addArrangedSubview(nextWeekButton)
        periodStack.addArrangedSubview(separateVerticalLine)
        periodStack.addArrangedSubview(nextTwoWeeksButton)
        periodStack.addArrangedSubview(secondSeparateLine)
        periodStack.addArrangedSubview(nextMonthButton)
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
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = forecastCollectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionViewCell", for: indexPath) as! ForecastCollectionViewCell
        
        return cell
    }
}

// MARK: - TableView Delegate & DataSource

extension ForecastView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNamesArray.count
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
        
        headerLabel.text = sectionNamesArray[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        
        return cell
        
    }
}

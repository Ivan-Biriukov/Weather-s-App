import UIKit

class PrecipitationView: UIView {

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = precipitationTableView.dequeueReusableCell(withIdentifier: "precipitationTableViewCell", for: indexPath) as! ForecastTableViewCell
        
        return cell
    }
    
    
}

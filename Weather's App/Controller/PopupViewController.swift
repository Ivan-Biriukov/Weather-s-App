import UIKit
import CoreData

class PopupViewController: UIViewController {
    
    //CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func loadItems() {
        let request : NSFetchRequest<SavedLocations> = SavedLocations.fetchRequest()
        do {
            locationsArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        self.locationsTableView.reloadData()
    }
    
    private var locationsArray = [SavedLocations]()
    
    private let notificationDataArra : [[String]] = [
        ["Send feedback", "Rate this app", "Share your weather"],
        ["arrowshape.turn.up.backward.fill", "star.fill", "circle.hexagonpath.fill"]
    ]
    
    // MARK: - UI Elements
    
    private lazy var dismissButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark.seal.fill"), for: .normal)
        btn.tintColor = .white
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(dismissButtonTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let locationTitle : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold16()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Location"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let topTableSeparate : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrayText
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let locationsTableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = true
        table.separatorStyle = .none
        table.indicatorStyle = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let botTableSeparate : UIView = {
        let view = UIView()
        view.backgroundColor = .darkGrayText
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let toolsTitle : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold16()
        lb.textColor = .white
        lb.textAlignment = .center
        lb.text = "Tools"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let notificationsTableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = true
        table.separatorStyle = .none
        table.isScrollEnabled = false
        table.indicatorStyle = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .additionalViewBackground
        addSubviews()
        setupConstraints()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadItems()
        self.locationsTableView.reloadData()
    }
    
    // MARK: - COnfigure UI
    
    private func addSubviews() {
        view.addSubview(dismissButton)
        view.addSubview(locationTitle)
        view.addSubview(topTableSeparate)
        view.addSubview(locationsTableView)
        view.addSubview(botTableSeparate)
        view.addSubview(toolsTitle)
        view.addSubview(notificationsTableView)
    }
    
    private func setupTableView() {
        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        locationsTableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "LocationTableViewCell")
        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
        notificationsTableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: "NotificationTableViewCell")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
            locationTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            locationTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            topTableSeparate.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: 10),
            topTableSeparate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            topTableSeparate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            locationsTableView.topAnchor.constraint(equalTo: topTableSeparate.bottomAnchor, constant: 10),
            locationsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationsTableView.heightAnchor.constraint(equalToConstant: 200),
        
            botTableSeparate.topAnchor.constraint(equalTo: locationsTableView.bottomAnchor, constant: 10),
            botTableSeparate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            botTableSeparate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            toolsTitle.topAnchor.constraint(equalTo: botTableSeparate.bottomAnchor, constant: 20),
            toolsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            notificationsTableView.topAnchor.constraint(equalTo: toolsTitle.bottomAnchor, constant: 10),
            notificationsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            notificationsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            notificationsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
    }
    
    // MARK: - Buttons Methods
    
    @objc func dismissButtonTaped() {
        dismiss(animated: true)
    }

}

// MARK: - TableView Delegate & DataSource

extension PopupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == locationsTableView {
            return locationsArray.count
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == locationsTableView{
            let cell = locationsTableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as! LocationTableViewCell
            let currentCellData = locationsArray[indexPath.row]
            cell.cityNameLabel.text = currentCellData.cityName
            cell.countyNameLabel.text = currentCellData.countryName
            cell.temperatureLabel.text = currentCellData.currentTemp
            cell.weatherConditionLabel.text = currentCellData.weatherConditionName
            return cell
        } else {
            let cell = notificationsTableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
            let currenttitle = notificationDataArra[0][indexPath.row]
            let currentImage = notificationDataArra[1][indexPath.row]
            cell.titleLabel.text = currenttitle
            cell.image.image = UIImage(systemName: currentImage)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == locationsTableView {
            context.delete(locationsArray[indexPath.row])
            locationsArray.remove(at: indexPath.row)
            tableView.reloadData()
            self.saveItems()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65
    }
    
    
}

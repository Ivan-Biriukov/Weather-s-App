import UIKit
import BonsaiController

class MainViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.backgroundColor = .clear
        return bar
    }()
    
    private lazy var accountButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: K.NavigationBar.accountButton)!, for: .normal)
        btn.addTarget(self, action: #selector(accountButtonTaped), for: .touchUpInside)
        btn.tintColor = .white
        return btn
    }()
    
    private lazy var threeDotsButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: K.NavigationBar.threeDotsButton)!, for: .normal)
        btn.tintColor = .white
        return btn
    }()

    private lazy var todayButton = SectionButton(title: "Today", status: .selected)
    private lazy var forecastButton = SectionButton(title: "Forecast", status: .unselected)
    private lazy var precipitationButton = SectionButton(title: "Precipitation", status: .unselected)
    
    private let topLaneButtonsStack : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 38
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let separateLine : UIView = {
        let line = UIView()
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true
        line.backgroundColor = .unselectedGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private let contentScrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let todayView = TodayView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1500))
    private let forecastView = ForecastView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 625))
    private let precipitationView = PrecipitationView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 625))
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainGradientBackground()
        addSubviews()
        setupConstraints()
        addButtonsTargets()
        setupNavBar()
        configureSearchBar()
        hideKeyboardWhenTappedAround()
        contentScrollView.delegate = self
    }
    
    // MARK: - Custom Buttons Methods
    
    @objc func accountButtonTaped() {
        let popupVC = PopupViewController()
        popupVC.transitioningDelegate = self
        popupVC.modalPresentationStyle = .custom
        self.present(popupVC, animated: true)
    }
    
    @objc func todayButtonTaped(_ sender: UIButton) {
        configureTodayView(isHiden: false)
        configureForecastView(isHiden: true)
        configurePrecipitationView(isHidden: true)
        
        changeButtonsTitleStyle(titleText: "Today", button: sender, selected: true)
        changeButtonsTitleStyle(titleText: "Forecast", button: forecastButton, selected: false)
        changeButtonsTitleStyle(titleText: "Precipitation", button: precipitationButton, selected: false)
    }
    
    @objc func forecastButtonTaped(_ sender: UIButton) {
        configureTodayView(isHiden: true)
        configureForecastView(isHiden: false)
        configurePrecipitationView(isHidden: true)
        
        changeButtonsTitleStyle(titleText: "Forecast", button: sender, selected: true)
        changeButtonsTitleStyle(titleText: "Today", button: todayButton, selected: false)
        changeButtonsTitleStyle(titleText: "Precipitation", button: precipitationButton, selected: false)
    }
    
    @objc func precipitationButtonTaped(_ sender: UIButton) {
        configureTodayView(isHiden: true)
        configureForecastView(isHiden: true)
        configurePrecipitationView(isHidden: false)
        
        changeButtonsTitleStyle(titleText: "Precipitation", button: sender, selected: true)
        changeButtonsTitleStyle(titleText: "Today", button: todayButton, selected: false)
        changeButtonsTitleStyle(titleText: "Forecast", button: forecastButton, selected: false)
    }
    
    

    // MARK: - Configure UI
    
    private func addSubviews() {
        view.addSubview(topLaneButtonsStack)
        topLaneButtonsStack.addArrangedSubview(todayButton)
        topLaneButtonsStack.addArrangedSubview(forecastButton)
        topLaneButtonsStack.addArrangedSubview(precipitationButton)
        view.addSubview(separateLine)
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(todayView)
    }
    
    private func addButtonsTargets() {
        todayButton.addTarget(self, action: #selector(todayButtonTaped(_:)), for: .touchUpInside)
        forecastButton.addTarget(self, action: #selector(forecastButtonTaped(_:)), for: .touchUpInside)
        precipitationButton.addTarget(self, action: #selector(precipitationButtonTaped(_:)), for: .touchUpInside)
    }
    
    private func setupNavBar() {
        self.navigationItem.titleView = searchBar
        let accountButtonLeft = UIBarButtonItem(customView: accountButton)
        self.navigationItem.leftBarButtonItem = accountButtonLeft
        let rightBarButton = UIBarButtonItem(customView: threeDotsButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.tintColor = .red
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.leftView?.tintColor = .white
        let dismissIcon = UIImage(systemName: "xmark.circle")
        dismissIcon!.withTintColor(UIColor.systemRed)
        searchBar.setImage(dismissIcon, for: .clear, state: .normal)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topLaneButtonsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            topLaneButtonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            topLaneButtonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
        
            separateLine.topAnchor.constraint(equalTo: topLaneButtonsStack.bottomAnchor, constant: 15),
            separateLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separateLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentScrollView.topAnchor.constraint(equalTo: separateLine.bottomAnchor, constant: 20),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            todayView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            todayView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            todayView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            todayView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
        ])
    }
    
    private func configureTodayView(isHiden : Bool) {
        todayView.isHidden = isHiden
        if isHiden {
            todayView.removeFromSuperview()
            NSLayoutConstraint.deactivate([
            todayView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            todayView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            todayView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            todayView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor)
            ])
        } else {
            contentScrollView.addSubview(todayView)
            NSLayoutConstraint.activate([
            todayView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            todayView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            todayView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            todayView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor)
            ])
        }
    }
    
    private func configureForecastView(isHiden : Bool) {
        forecastView.isHidden = isHiden
        if isHiden {
            forecastView.removeFromSuperview()
            NSLayoutConstraint.deactivate([
                forecastView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
                forecastView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
                forecastView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
                forecastView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor,constant: -25),
            ])
        } else {
            contentScrollView.addSubview(forecastView)
            NSLayoutConstraint.activate([
                forecastView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
                forecastView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
                forecastView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
                forecastView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor, constant:  -25),
            ])
        }
    }
    
    private func configurePrecipitationView(isHidden: Bool) {
        precipitationView.isHidden = isHidden
        if isHidden {
            precipitationView.removeFromSuperview()
            NSLayoutConstraint.deactivate([
                precipitationView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
                precipitationView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
                precipitationView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
                precipitationView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor,constant: -25),
            ])
        } else {
            contentScrollView.addSubview(precipitationView)
            NSLayoutConstraint.activate([
                precipitationView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
                precipitationView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
                precipitationView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
                precipitationView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor,constant: -25),
            ])
        }
    }
}


// MARK: - SearchBar Delegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - ScrollView Delegate

extension MainViewController: UIScrollViewDelegate {
    
}


// MARK: - Bonsai Delegate

extension MainViewController: BonsaiControllerDelegate {
    
    // return the frame of your Bonsai View Controller
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: containerViewFrame.width - 80, height: containerViewFrame.height ))
    }
    
    // return a Bonsai Controller with SlideIn or Bubble transition animator
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
    
        return BonsaiController(fromDirection: .left, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)
    }
}

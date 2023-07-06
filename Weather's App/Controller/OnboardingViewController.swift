import UIKit

class OnboardingViewController: UIViewController {
    
    private var currentPageNumber = 0
    
    // MARK: - UI Elements
    
    private let contentView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2).isActive = true
        view.layer.cornerRadius = 234
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var skipButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Skip", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .poppinsMedium14()
        btn.addTarget(self, action: #selector(skipTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let colletionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 220)
        c.backgroundColor = .clear
        c.showsHorizontalScrollIndicator = false
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()

    private lazy var colletionViewPageControll : UIPageControl = {
        let control = UIPageControl()
        control.isUserInteractionEnabled = false
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let titleLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsSemiBold28()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .darkText
        lb.text = OnboardingDataManager.dataArray[0].mainTitleText
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let discriptionLabel : UILabel = {
        let lb = UILabel()
        lb.font = .poppinsRegular16()
        lb.minimumScaleFactor = 0.1
        lb.adjustsFontSizeToFitWidth = true
        lb.lineBreakMode = .byClipping
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .lightGrayText
        lb.text = OnboardingDataManager.dataArray[0].descriptionText
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var nextButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: K.Onboarding.ButtonsImages.firstStage)!, for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 80).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn.addTarget(self, action: #selector(nextButtonTaped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let contentStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setMainGradientBackground()
        addSubViews()
        setupConstraints()
        setupCollection()
        configureInfoPageControll()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.set(true, forKey: "onboardingComplete")
    }

    // MARK: - Buttons Methods
    
    @objc func skipTaped() {
        skipButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.skipButton.alpha = 1
            let newVC = MainViewController()
            newVC.modalPresentationStyle = .fullScreen
            self.present(newVC, animated: true)
        }
    }
    
    @objc func nextButtonTaped() {
        if currentPageNumber <= 3 {
            currentPageNumber += 1
        }
        updateUI(pageNumber: currentPageNumber)
    }
    
    
    // MARK: - Configure UI
    
    private func addSubViews() {
        view.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(discriptionLabel)
        contentStackView.addArrangedSubview(nextButton)
        view.addSubview(skipButton)
        view.addSubview(colletionView)
        view.addSubview(colletionViewPageControll)
    }
    
    private func setupCollection() {
        self.colletionView.delegate = self
        self.colletionView.dataSource = self
        self.colletionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "OnboardingCell")
    }
    
    private func configureInfoPageControll() {
        colletionViewPageControll.numberOfPages = OnboardingDataManager.dataArray.count
        colletionViewPageControll.currentPage = 0
        if #available(iOS 14.0, *) {
            colletionViewPageControll.preferredIndicatorImage = UIImage(named: K.Onboarding.CollectionIndicators.unselected)
        }
        colletionViewPageControll.pageIndicatorTintColor = .white
        colletionViewPageControll.currentPageIndicatorTintColor = .black
        if #available(iOS 16.0, *) {
            colletionViewPageControll.preferredCurrentPageIndicatorImage = UIImage(named: K.Onboarding.CollectionIndicators.selected)
        }
    }
    
    private func updateUI(pageNumber num: Int) {
        if num < 4 {
            let indexPath = NSIndexPath(row: num, section: 0)
            let data = OnboardingDataManager.dataArray[num]
            colletionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
            colletionViewPageControll.currentPage = num
            titleLabel.text = data.mainTitleText
            discriptionLabel.text = data.descriptionText
            nextButton.setImage(UIImage(named: data.nextButtonImage), for: .normal)
        } else {
            let newVC = MainViewController()
            newVC.modalPresentationStyle = .fullScreen
            present(newVC, animated: true)
        }

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            colletionView.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 10),
            colletionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colletionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colletionView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -30),
            colletionViewPageControll.topAnchor.constraint(equalTo: colletionView.bottomAnchor, constant: -50),
            colletionViewPageControll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -50),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 50),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 54),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -54),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35)
        ])
    }
}

 // MARK: - Collection Delegate & DataSource

extension OnboardingViewController : UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OnboardingDataManager.dataArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCollectionViewCell
        let currentItem = OnboardingDataManager.dataArray[indexPath.row]
        cell.cellData = currentItem
        return cell
    }
}




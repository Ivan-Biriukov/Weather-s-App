import UIKit

class MainViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var myController = [UIViewController]()
    
    // MARK: - UI Elements

    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addVCsToPageController()
        presentPageVC()
    }
    
    // MARK: - PageController Section
    
    private func addVCsToPageController() {
        myController.append(TodayViewController())
        myController.append(ForecastViewController())
        myController.append(PrecipitationViewController())
    }
    
    private func presentPageVC() {
        guard let firstVC = myController.first else {return}
        
        let vc = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal)
        vc.delegate = self
        vc.dataSource = self
        vc.setViewControllers([firstVC], direction: .forward, animated: true)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = myController.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        
        let before = index - 1
        return myController[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = myController.firstIndex(of: viewController), index < (myController.count - 1) else {
            return nil
        }
        
        let after = index + 1
        return myController[after]
    }
    
    // MARK: - Custom Buttons Methods
    
    

    // MARK: - Configure UI
    
    
  

}

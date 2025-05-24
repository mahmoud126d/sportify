//
//  OnboardingPageViewController.swift
//  Sportify
//
//  Created by Aya Emam on 23/05/2025.
//

import UIKit

class OnboardingPageViewController: UIPageViewController , UIPageViewControllerDataSource {

    private lazy var pages: [OnboardingContentViewController] = {
        let page1 = OnboardingContentViewController(nibName: "OnboardingContentViewController", bundle: nil)
        page1.text = NSLocalizedString("onboarding_page1_text", comment: "message")

        page1.imageToShow = UIImage(named: "onboarding2")
        page1.showGetStartedButton = false
        let page2 = OnboardingContentViewController(nibName: "OnboardingContentViewController", bundle: nil)
        page2.text = NSLocalizedString("onboarding_page2_text", comment: "message")

        page2.imageToShow = UIImage(named: "onboarding3")
        page2.showGetStartedButton = true
        page2.onGetStarted = { [weak self] in
                self?.finishOnboarding()
            }
            return [page1, page2]
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        view.backgroundColor = .black
        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! OnboardingContentViewController), index > 0 else { return nil }
        return pages[index - 1]
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = pages.firstIndex(of: viewController as! OnboardingContentViewController), index < pages.count - 1 else { return nil }
            return pages[index + 1]
        }

        private func finishOnboarding() {
            UserDefaults.standard.set(true, forKey: "Onboarding")
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.showMainApp()
            }
        }


}

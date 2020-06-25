//
//  PageViewController.swift
//  Module8
//
//  Created by Sergey Chistov on 04.06.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    private let controllers = [
        UIStoryboard(name: "Main", bundle:nil).instantiateViewController(identifier: "ViewControllerA") as ViewControllerA,
        UIStoryboard(name: "Main", bundle:nil).instantiateViewController(identifier: "ViewControllerB") as ViewControllerB,
        UIStoryboard(name: "Main", bundle:nil).instantiateViewController(identifier: "ViewControllerC") as ViewControllerC
    ]

    private var currentIndex = 0;

    override func viewDidLoad() {
        dataSource = self
        setViewControllers([controllers[currentIndex]], direction: .forward, animated: true, completion: nil)
    }
}

extension PageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let i = controllers.firstIndex(of: viewController) else { return nil }
        let index = i - 1
        return index >= 0 ? controllers[index] : controllers.last
    } 

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let i = controllers.firstIndex(of: viewController) else { return nil }
        let index = i + 1
        return index < controllers.count ? controllers[index] : controllers.first
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }

}

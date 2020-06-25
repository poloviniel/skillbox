//
//  SceneDelegate.swift
//  Module7_additional
//
//  Created by Sergey Chistov on 25.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        guard let scene = scene as? UIWindowScene else { return }
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene

        let mainVC = CustomContainerController2()
        mainVC.view.backgroundColor = UIColor.white
        mainVC.view.translatesAutoresizingMaskIntoConstraints = false
        mainVC.addChildController(makeVC(UIColor.red))
        mainVC.addChildController(makeVC(UIColor.orange))
        mainVC.addChildController(makeVC(UIColor.yellow))
        mainVC.addChildController(makeVC(UIColor.green))
        mainVC.addChildController(makeVC(UIColor.cyan))
        mainVC.addChildController(makeVC(UIColor.blue))
        //mainVC.addChildController(makeVC(UIColor.purple)) // precondition жахнет, это седьмой

        //mainVC.placeholder = makePlaceholder() // кастомный плейсходер пожалуйста

        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }

    private func makeVC(_ color: UIColor) -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = color
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }

    private func makePlaceholder() -> UIViewController {
        let vc = UIViewController()
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Georgia", size: 40)
        label.textColor = UIColor.gray
        label.text = "NO CHILDS HERE"
        vc.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor)
        ])
        return vc
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


//
//  SceneDelegate.swift
//  TrendMedia
//
//  Created by J on 2022/07/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // user한테 어떻게 보여줄지 조정하는 아이
    var window: UIWindow?

    // 시작화면 조정
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        UserDefaults.standard.set(false, forKey: "First") // True이면 SenceViewController화면, false이면 SearchMovieTableViewController
        
        if UserDefaults.standard.bool(forKey: "First") {
            guard let scene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: scene)
            
            let sb = UIStoryboard(name: "Trend", bundle: nil)
            
            let vc = sb.instantiateViewController(withIdentifier: "SenceViewController") as! SenceViewController
            
            window?.rootViewController = vc
           
        } else {
            guard let scene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: scene)
            
            let sb = UIStoryboard(name: "Setting", bundle: nil)
            
            let vc = sb.instantiateViewController(withIdentifier: "SearchMovieTableViewController") as! SearchMovieTableViewController
            
            window?.rootViewController = UINavigationController(rootViewController: vc)
           
        }
        
        // 화면에 띄어주기 위한 메서드
        window?.makeKeyAndVisible()
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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


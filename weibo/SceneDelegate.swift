//
//  SceneDelegate.swift
//  weibo
//
//  Created by liyang on 2024/8/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    setupAppeareance()
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
//    window?.rootViewController = MainViewController()
//    window?.rootViewController = NewFeatureViewController()
    window?.rootViewController = WelcomeViewController()
    window?.makeKeyAndVisible()
    print(isNewVersion)
  }

  // 设置全局外观 - 在很多应用中，都会在SceneDelegate中设置所有需要控件的全局外观
  private func setupAppeareance() {
    // 修改导航栏的全局外观, 要在控件创建之前设置, 一经设置全局有效
    UINavigationBar.appearance().tintColor = WBAppearanceTintColor
    //
    UITabBar.appearance().tintColor = WBAppearanceTintColor
  }
}

extension SceneDelegate {
  // 判断是否是最新版本
  private var isNewVersion: Bool {
    // 1. 当前版本
    let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    let version = Double(currentVersion)!
    print("当前版本 \(String(describing: version))")
    // 2. 之前的版本, 把当前的版本保存在用户偏好
    let sandboxVersionKey = "sandboxVersionKey"
    let sandboxVersion = UserDefaults.standard.double(forKey: sandboxVersionKey)
    print("之前版本 \(sandboxVersion)")
    // 3. 保存当前版本
    UserDefaults.standard.set(version, forKey: sandboxVersionKey)
    return version > sandboxVersion
  }
}


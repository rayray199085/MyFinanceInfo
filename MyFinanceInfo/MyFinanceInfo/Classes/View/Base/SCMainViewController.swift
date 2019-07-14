//
//  SCMainViewController.swift
//  MyFinanceInfo
//
//  Created by Stephen Cao on 14/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCMainViewController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        tabBar.barTintColor = InfoCommon.barColor
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    
}
private extension SCMainViewController{
    
    /// setup child controllers by initializing an array of dictionary
    func setupChildControllers(){
        guard let path = Bundle.main.path(forResource: "main", ofType: "json"),
             let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let array = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else{
                return
        }
        var childControllers = [UIViewController]()
        for dict in array{
            childControllers.append(getController(dict: dict))
        }
        viewControllers = childControllers
    }
    
    /// get child controllers
    ///
    /// - Parameter dict: dictionary contains titile, class and tab bar image
    /// - Returns: child controller
    func getController(dict: [String: Any])->UIViewController{
        guard let clsName = dict["clsName"] as? String,
              let cls = NSClassFromString(Bundle.main.nameSpace + "." + clsName) as? UIViewController.Type,
              let title = dict["title"] as? String,
              let imageName = dict["imageName"] as? String else{
                return UIViewController()
        }
        let vc = cls.init()
        vc.title = title
        let normalImageName = "tabbar_\(imageName)"
        vc.tabBarItem.image = UIImage(named: normalImageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(
            named: normalImageName + "_selected")?.withRenderingMode(
                UIImage.RenderingMode.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor : InfoCommon.tinColor],
            for: UIControl.State.highlighted)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)], for: [])
        let nav = SCNavigationViewController(rootViewController: vc)
        return nav
    }
}

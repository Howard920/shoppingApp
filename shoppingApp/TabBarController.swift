//
//  TabBarController.swift
//  shoppingApp
//
//  Created by 杜襄 on 2021/11/23.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool
    {
        
        if viewController.restorationIdentifier == "Cart"
        {
            
            let storyboard = UIStoryboard(name: "Cart", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "Cart")
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true, completion: nil)
            
            return false
        }
        
        return true
               
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

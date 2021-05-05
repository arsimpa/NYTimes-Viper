//
//  SecondViewController.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 06/05/2021.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Side Menu Configuration
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
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

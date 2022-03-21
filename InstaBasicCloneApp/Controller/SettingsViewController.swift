//
//  SettingsViewController.swift
//  InstaBasicCloneApp
//
//  Created by Talha Varol on 20.03.2022.
//

import UIKit
import Firebase
class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
        //Kullanıcı firebase üzerinden sistemden çıkış yapabilsin ve öylece tekrar açtığında login olmak zorunda kalsın dedik.
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toVC", sender: nil)
        }catch{
            print("Error")
        }


}
}

//
//  EditProfileController.swift
//  ToDo
//
//  Created by Work on 4/29/19.
//  Copyright © 2019 Kian. All rights reserved.
//

import UIKit

class EditProfileController: UIViewController {
    @IBOutlet weak var nameTxt: UILabel!
    var plistManager = PlistHandler()
    
    
    @IBAction func logoutBtnClicked(_ sender: UIButton) {
        
        let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "mainPage") as! MainController
        
        navigationController?.pushViewController(loginPage, animated: true)
        
    }
    
    
    @IBAction func doneBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTxt.text = plistManager.plistReader(name: "token.plist")["name"]! as? String

        
        // Do any additional setup after loading the view.
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

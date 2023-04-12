//
//  LoginController.swift
//  ToDo
//
//  Created by Work on 4/29/19.
//  Copyright © 2019 Kian. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    var apiManager = apiHandler()
   
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        
    let groupListPage = self.storyboard?.instantiateViewController(withIdentifier: "groupList") as! GroupListController
    
    
        
        if (emailText.text != nil && passwordText.text != nil){
            
            apiManager.loginManager(info: ["email" : emailText.text! , "password" : passwordText.text!]) { (result) in
               // print(result)
                
                if (result){
                    print("ok")
                    
                    DispatchQueue.main.sync {
                        self.navigationController?.pushViewController(groupListPage, animated: true)
                    }
                    
                }else{
                    
                    DispatchQueue.main.sync {
                        let alert = UIAlertController.init(title: "خطا", message: "نام کاربری یا رمز عبور اشتباه است", preferredStyle: .alert)
                        let action = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
                        alert.addAction(action)
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                
                }
               
            }
        }
       
        
    }
    
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        
    
        super.viewDidLoad()

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

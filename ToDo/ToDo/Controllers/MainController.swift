//
//  MainController.swift
//  ToDo
//
//  Created by Work on 4/29/19.
//  Copyright © 2019 Kian. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    var plistManager = PlistHandler()
    var sandboxManager = SandboxHandler()
    var apiManager = apiHandler()

    @IBAction func signupBtnClicked(_ sender: UIButton) {
            let signupPage = self.storyboard?.instantiateViewController(withIdentifier: "signupPage") as! SignUpController
        
        navigationController?.pushViewController(signupPage, animated: true)
    }
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
            let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "loginPage") as! LoginController
        
        navigationController?.pushViewController(loginPage, animated: true)
      
        
    }
    
    
    override func viewDidLoad() {
        
        
     // print(plistManager.readToken(name: "token.plist"))
      print(sandboxManager.getSandBoxPath())
        
     //OK  apiManager.loginManager(info: ["email" : "test@yahoo.com" , "password" : "testr"])
     //OK  apiManager.registerManager(info: ["first_name" : "api" , "last_name" : "apiI" , "password" : "api" , "email" : "api@yahoo.com"])
     //OK  apiManager.createGroupManager(info: ["groupName":"tahaaa"])
     //OK  apiManager.deleteGroupManager(info: ["group_id" : "864"])
     //OK  apiManager.updateGroupManager(info: ["groupName":"kiann" , "group_id" : "865"])
     //OK  apiManager.getGroupManager(info: ["group_id":""]) { (data) in
     //       print(data)
     //  }
        
        
        
     //OK  apiManager.createTaskManager(info: ["group_id" : "661" , "taskName" : "skk" , "taskDescription" : "dsdc" , "executionTime" : "cdsc" ])
     //OK apiManager.deleteTaskManager(info: ["task_id" : "829"])
     //OK  apiManager.getTaskManager(info: ["group_id":"877"]) { (result) in
     //    print(result)
     // }
     //OK apiManager.updateTaskManager(info: ["task_id" : "843" , "group_id" : "877" , "taskName" : "ddkian" , "doneStatus" : false , "taskDescription" : "edwc" , "executionTime" : "cdclm"])
     //
        
        
        
        
        
        navigationController?.navigationBar.isHidden = true
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

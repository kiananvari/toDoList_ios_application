//
//  GroupListController.swift
//  ToDo
//
//  Created by Work on 4/29/19.
//  Copyright © 2019 Kian. All rights reserved.
//

import UIKit

var userInfo = [Any]()

class GroupListController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    @IBOutlet weak var newGorupTxt: UITextField!
    @IBOutlet weak var newBtn: UIButton!
    var DataDic : [[String:Any]] = [["":0]]
    var apiManager = apiHandler()
    var count = 0
    var flag = 0
    @IBOutlet weak var tblView: UITableView!
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "")
        
       cell.textLabel?.text = "\(DataDic[indexPath.row]["name"]!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(DataDic[indexPath.row]["id"]!)
        
        userInfo = [DataDic[indexPath.row]["id"]! , DataDic[indexPath.row]["name"]! ]
        
       // userInfo["gorup_id" : DataDic[indexPath.row]["id"] , "gorup_name" : DataDic[indexPath.row]["name"] ]
        
        
        tblView.deselectRow(at: indexPath, animated: true)
        let taskListPage = self.storyboard?.instantiateViewController(withIdentifier: "taskList") as! TaskListController
        navigationController?.pushViewController(taskListPage, animated: true)
 
    }
    

    var plistManager = PlistHandler()
    
    
    
    @IBOutlet weak var profileBtnTxt: UIButton!
    @IBAction func profileBtnClicked(_ sender: UIButton) {
        
        
        let editProfilePage = self.storyboard?.instantiateViewController(withIdentifier: "editProfile") as! EditProfileController
        
    self.navigationController?.pushViewController(editProfilePage, animated: true)
       
        print("clicked")
        
    }
    
    
    @IBAction func newBtnClicked(_ sender: UIButton) {
        
        if (newGorupTxt.text != ""){
        
            apiManager.createGroupManager(info: ["groupName":newGorupTxt.text!]) { (state) in
                
                if (state == true){
                    
                    DispatchQueue.main.async {
                        let niceAlrt = UIAlertController.init(title: "موفقیت", message: "گروه جدید با موفقیت اضافه شد", preferredStyle: .actionSheet)
                        let alertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
                        niceAlrt.addAction(alertAction)
                        self.present(niceAlrt, animated: true, completion: nil)
                        self.fillTable()
                    }
                }else {
                    
                    DispatchQueue.main.async {
                        
                        let badAlrt = UIAlertController.init(title: "خطا", message: "خطا", preferredStyle: .actionSheet)
                        let alertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
                        badAlrt.addAction(alertAction)
                        self.present(badAlrt, animated: true, completion: nil)
                        self.fillTable()
                    }
                }
            }
        }
    }
    
    
    func fillTable (){
        
        apiManager.getGroupManager(info: ["group_id":""]) { (data) in
            
            self.DataDic = data
            self.count = data.count
            DispatchQueue.main.async {
                
                self.tblView.reloadData()
            }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fillTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillTable()
        

        newBtn.layer.cornerRadius = newBtn.bounds.size.height/3
        newBtn.clipsToBounds = true
       
  
       

        profileBtnTxt.setTitle(plistManager.plistReader(name: "token.plist")["name"]! as? String, for: .normal)

        // Do any additional setup after loading the view.
    }
    
}

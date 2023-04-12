//
//  TaskListController.swift
//  ToDo
//
//  Created by Work on 4/29/19.
//  Copyright © 2019 Kian. All rights reserved.
//

import UIKit

var TaskInfo = [Any]()

class TaskListController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView == taskTblView) {
            
            return taskDic.count
            
            
        } else {
            
            return doneDic.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (tableView == taskTblView) {
            
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
            
            cell.textLabel?.text = taskDic[indexPath.row]["taskName"] as? String
            
            return cell
            
            
        } else {
            
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
            
            cell.textLabel?.text = doneDic[indexPath.row]["taskName"] as? String

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView == taskTblView){
            

            TaskInfo = [taskDic[indexPath.row]["id"]! , taskDic[indexPath.row]["taskName"]! ,taskDic[indexPath.row]["taskDescription"]! , taskDic[indexPath.row]["executionTime"]!,taskDic[indexPath.row]["doneStatus"]!]
            print(TaskInfo)
            let taskInfoPage = self.storyboard?.instantiateViewController(withIdentifier: "taskInfo") as! TaskInfoController
            navigationController?.pushViewController(taskInfoPage, animated: true)
            
        }else{
            
             TaskInfo = [doneDic[indexPath.row]["id"]! , doneDic[indexPath.row]["taskName"]! ,doneDic[indexPath.row]["taskDescription"]! , doneDic[indexPath.row]["executionTime"]!,doneDic[indexPath.row]["doneStatus"]!]
            
            let taskInfoPage = self.storyboard?.instantiateViewController(withIdentifier: "taskInfo") as! TaskInfoController
            navigationController?.pushViewController(taskInfoPage, animated: true)
        }
        
        
        
        doneTblView.deselectRow(at: indexPath, animated: true)
        taskTblView.deselectRow(at: indexPath, animated: true)
    }
    
    
    var doneDic = [[String:Any]]()
    var taskDic = [[String:Any]]()
    @IBOutlet weak var taskTblView: UITableView!
    @IBOutlet weak var doneTblView: UITableView!
    var apiManager = apiHandler()
    var group_id = 0
    
    @IBOutlet weak var groupNameLbl: UILabel!
    @IBOutlet weak var editGroupTxt: UITextField!
    
    @IBAction func newTaskClicked(_ sender: UIButton) {
        let newTaskPage = self.storyboard?.instantiateViewController(withIdentifier: "newTask") as! NewTaskController
        navigationController?.pushViewController(newTaskPage, animated: true)
        
    }
    
    @IBAction func editGroupBtnClicked(_ sender: UIButton) {
        
        if (editGroupTxt.text != ""){
            
            apiManager.updateGroupManager(info: ["groupName":editGroupTxt.text! , "group_id" : "\(group_id)"]) { (state) in
                
                if(state == true) {
                    
                    DispatchQueue.main.async {
                        
                        let okAlert = UIAlertController.init(title: "موفقیت", message: "نام گروه تغییر کرد", preferredStyle: .alert)
                        let okAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
                        okAlert.addAction(okAlertAction)
                        self.present(okAlert, animated: true, completion: nil)
                        self.groupNameLbl.text = self.editGroupTxt.text
                        
                    }
                    
                }else{
                    
                    DispatchQueue.main.async {
                        
                        let falseAlert = UIAlertController.init(title: "خطا", message: "نام گروه تغییر نکرد !", preferredStyle: .alert)
                        let falseAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
                        falseAlert.addAction(falseAlertAction)
                        self.present(falseAlert, animated: true, completion: nil)
                        
                        
                    }
                    
                }
            }
            
        }
        
    }
    
    @IBAction func deleteGroupBtnClicked(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            
            let isDeleteAlaram = UIAlertController.init(title: "اطمینان", message: "آیا میخاهید این گروه را حذف نمایید ؟", preferredStyle: .alert)
            let yesAction = UIAlertAction.init(title: "بله", style: .cancel) { (result) in
                
                self.apiManager.deleteGroupManager(info: ["group_id" : "\(self.group_id)"] , state: { (state) in
                    
                    if (state == true) {
                        
                        DispatchQueue.main.async {
                            
                            let okAlert = UIAlertController.init(title: "موفقیت", message: "گروه با موفقیت حذف شد", preferredStyle: .alert)
                            let okAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: { (action) in
                                self.navigationController?.popViewController(animated: true)
                            })
                            
                            okAlert.addAction(okAlertAction)
                            self.present(okAlert, animated: true, completion: nil)
                            
                        }
                        
                    } else {
                        
                        DispatchQueue.main.async {
                            
                            let falseAlert = UIAlertController.init(title: "خطا", message: "گروه حذف نشد", preferredStyle: .alert)
                            let falseAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
                            falseAlert.addAction(falseAlertAction)
                            self.present(falseAlert, animated: true, completion: nil)
                            
                            
                        }
                        
                    }
                    
                    
                    
                })
                
            }
            let noAction = UIAlertAction.init(title: "خیر", style: .default, handler: nil)
            
            isDeleteAlaram.addAction(yesAction)
            isDeleteAlaram.addAction(noAction)
            
                self.present(isDeleteAlaram, animated: true, completion: nil)
        }
       
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func devideDics(){
        
        apiManager.getTaskManager(info: ["group_id":"\(group_id)"]) { (result) in
           // print(item["doneStatus"]!)
        
            for item in result {

                if (item["doneStatus"]! as! Int == 0) {
                    
                   self.taskDic.append(item)
                    
                }else{
                    
                    self.doneDic.append(item)
                    
                    
                }
                
            }
         
           // self.taskDic.remove(at: 0)
            //self.doneDic.remove(at: 0)
            DispatchQueue.main.async {
                
                self.taskTblView.reloadData()
                self.doneTblView.reloadData()
                
            }
       
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        taskDic.removeAll()
        doneDic.removeAll()
        devideDics()
        
    }
    
    override func viewDidLoad() {
        
        groupNameLbl.text = "\(userInfo[1])"
        group_id = userInfo[0] as! Int
//        taskDic.removeAll()
//        doneDic.removeAll()
//        devideDics()
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

//
//  TaskInfoController.swift
//  ToDo
//
//  Created by Work on 4/29/19.
//  Copyright © 2019 Kian. All rights reserved.
//

import UIKit

class TaskInfoController: UIViewController {
    
    var apiManager = apiHandler()
    var task_id = 0
    var group_id = 0
    var status = 0
    var dateStr = ""
    @IBOutlet weak var dataView: UIDatePicker!
    @IBOutlet weak var taskNamelLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var desLblTxt: UILabel!
    @IBOutlet weak var dateTxt: UILabel!
    @IBOutlet weak var newNameTxt: UITextField!
    @IBOutlet weak var newDesTxt: UITextField!
    @IBOutlet weak var btnStatus: UIButton!
    
    
    
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneBtnClicked(_ sender: UIButton) {
        
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-YYYY"
        
        let strDate = dateFormatter.string(from: dataView.date)
        
        dateStr = strDate
    
        
        if(newDesTxt.text == "" && newNameTxt.text! == ""){
            
            apiManager.updateTaskManager(info: ["task_id" : "\(task_id)" , "group_id" : "\(group_id)" , "taskName" : TaskInfo[1] as? String , "doneStatus" : status , "taskDescription" : TaskInfo[2] as? String , "executionTime" : dateStr]) { (state) in
                
                if (state == true) {
                    
                    DispatchQueue.main.async {
                        
                        let okAlert = UIAlertController.init(title: "موفقیت", message: "با موفقیت تغییر کرد", preferredStyle: .alert)
                        let okAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: { (action) in
                            self.navigationController?.popViewController(animated: true)
                        })
                        
                        okAlert.addAction(okAlertAction)
                        self.present(okAlert, animated: true, completion: nil)
                        
                    }
                    
                } else {
                    
                    DispatchQueue.main.async {
                        
                        let falseAlert = UIAlertController.init(title: "خطا", message: "تغییر نکرد", preferredStyle: .alert)
                        let falseAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
                        falseAlert.addAction(falseAlertAction)
                        self.present(falseAlert, animated: true, completion: nil)
                        
                        
                    }
                    
                }
            
            
            
            
        }
        }
        
        
       if(newDesTxt.text != "" && newNameTxt.text! != ""){
            
            apiManager.updateTaskManager(info: ["task_id" : "\(task_id)" , "group_id" : "\(group_id)" , "taskName" : newNameTxt.text! , "doneStatus" : status , "taskDescription" : newDesTxt.text! , "executionTime" : dateStr]) { (state) in
                
                if (state == true) {
                    
                    DispatchQueue.main.async {
                        
                        let okAlert = UIAlertController.init(title: "موفقیت", message: "با موفقیت تغییر کرد", preferredStyle: .alert)
                        let okAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: { (action) in
                            self.navigationController?.popViewController(animated: true)
                        })
                        
                        okAlert.addAction(okAlertAction)
                        self.present(okAlert, animated: true, completion: nil)
                        
                    }
                    
                } else {
                    
                    DispatchQueue.main.async {
                        
                        let falseAlert = UIAlertController.init(title: "خطا", message: "تغییر نکرد", preferredStyle: .alert)
                        let falseAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
                        falseAlert.addAction(falseAlertAction)
                        self.present(falseAlert, animated: true, completion: nil)
                        
                        
                    }
                    
                }
                
            }
    }
        
        
    
    }
    
    @IBAction func deleteBtnClicked(_ sender: UIButton) {
        
        
        DispatchQueue.main.async {
            
            let isDeleteAlaram = UIAlertController.init(title: "اطمینان", message: "آیا میخاهید این وظیفه را حذف نمایید ؟", preferredStyle: .alert)
            let yesAction = UIAlertAction.init(title: "بله", style: .cancel) { (result) in
                
                self.apiManager.deleteTaskManager(info: ["task_id" : "\(self.task_id)"]) { (state) in
                    
                    if (state == true) {
                        
                        DispatchQueue.main.async {
                            
                            let okAlert = UIAlertController.init(title: "موفقیت", message: "وظیفه با موفقیت حذف شد", preferredStyle: .alert)
                            let okAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: { (action) in
                                self.navigationController?.popViewController(animated: true)
                            })
                            
                            okAlert.addAction(okAlertAction)
                            self.present(okAlert, animated: true, completion: nil)
                            
                        }
                        
                    } else {
                        
                        DispatchQueue.main.async {
                            
                            let falseAlert = UIAlertController.init(title: "خطا", message: "وظیفه حذف نشد", preferredStyle: .alert)
                            let falseAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
                            falseAlert.addAction(falseAlertAction)
                            self.present(falseAlert, animated: true, completion: nil)
                            
                            
                        }
                        
                    }
                    
                }
                
            }
            let noAction = UIAlertAction.init(title: "خیر", style: .default, handler: nil)
            
            isDeleteAlaram.addAction(yesAction)
            isDeleteAlaram.addAction(noAction)
            
            self.present(isDeleteAlaram, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func statusBtnClicked(_ sender: UIButton) {
        
        if (status == 0){
            
            status = 1
             btnStatus.setTitle("انجام شده", for: .normal)
            sender.backgroundColor = UIColor.blue
            
        }else{
            
            status = 0
             btnStatus.setTitle("انجام نشده", for: .normal)
            sender.backgroundColor = UIColor.red
        }
        
    }
    override func viewDidLoad() {
        
        dataView.datePickerMode = .date
        taskNamelLbl.text = TaskInfo[1] as? String
        task_id = TaskInfo[0] as! Int
        group_id = userInfo[0] as! Int
        desLblTxt.text = TaskInfo[2] as? String
        dateTxt.text = TaskInfo[3] as? String
        status = TaskInfo[4] as! Int
        if (status == 1) {
            btnStatus.setTitle("انجام شده", for: .normal)
            btnStatus.backgroundColor = UIColor.blue
        }
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

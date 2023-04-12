//
//  NewTaskController.swift
//  ToDo
//
//  Created by Work on 4/29/19.
//  Copyright © 2019 Kian. All rights reserved.
//

import UIKit

class NewTaskController: UIViewController {
    
    var apiManager = apiHandler()
    var group_id = 0
    @IBOutlet weak var nameTaskTxt: UITextField!
    @IBOutlet weak var desTaskTxt: UITextField!
    @IBOutlet weak var dateView: UIDatePicker!
    var dateStr = ""
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneBtnClicked(_ sender: UIButton) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-YYYY"
        
        let strDate = dateFormatter.string(from: dateView.date)
        
        dateStr = strDate
        
        if (nameTaskTxt.text != "" && desTaskTxt.text != ""){
            
            apiManager.createTaskManager(info: ["group_id" : "\(group_id)" , "taskName" : nameTaskTxt.text! , "taskDescription" : desTaskTxt.text! , "executionTime" : dateStr ]) { (state) in
                
                if (state == true){
                    DispatchQueue.main.async {
                        
                        let okAlarm = UIAlertController.init(title: "موفقیت", message: "وضیفه جدید با موفقیت اضافه شد", preferredStyle: .actionSheet)
                        let okAlarmAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: { (result) in
                            
                            self.navigationController?.popViewController(animated: true)
                        })
                        okAlarm.addAction(okAlarmAction)
                        self.present(okAlarm, animated: true, completion: nil)
                        
                    }
                   
                }else{
                    
                    DispatchQueue.main.async {
                        
                        let falseAlarm = UIAlertController.init(title: "خطا", message: "خطا", preferredStyle: .actionSheet)
                        let falseAlarmAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
                        falseAlarm.addAction(falseAlarmAction)
                        self.present(falseAlarm, animated: true, completion: nil)
                    }
                    
                }
                
                
            }
            
        }
        
       
        
    }
    
    override func viewDidLoad() {
         dateView.alpha = 1
         dateView.datePickerMode = .date
         group_id = userInfo[0] as! Int
        
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

//
//  SignUpController.swift
//  ToDo
//
//  Created by Work on 4/29/19.
//  Copyright © 2019 Kian. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {

    var apiManager = apiHandler()
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var fnameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repasswordTxt: UITextField!
  
  
    
    @IBAction func registerBtnClicked(_ sender: UIButton) {
        
        if (nameTxt.text == "" || fnameTxt.text == "" || passwordTxt.text == "" || emailTxt.text == ""){
            
            let alaram = UIAlertController.init(title: "اطلاعات", message: "لطفا اطلاعات خود را وارد کنید", preferredStyle: .alert)
            let alaramAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
            alaram.addAction(alaramAction)
            self.present(alaram, animated: true, completion:   nil)
            
        }
        
        
        if (repasswordTxt.text == passwordTxt.text){
            
            if (nameTxt.text != nil && fnameTxt.text != nil && passwordTxt.text != nil && emailTxt.text != nil){
                
                apiManager.registerManager(info: ["first_name" : nameTxt.text! , "last_name" : fnameTxt.text! , "password" : passwordTxt.text! , "email" : emailTxt.text!]) { (result) in
                    
                    if (result == true) {
                        
                        print("ok")
                             let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "loginPage") as! LoginController
                        
                        DispatchQueue.main.async {
                            
                            let okAlarm = UIAlertController.init(title: "اشتراک", message: "شما با موفقیت ثبت نام کردید . لطفا وارد شوید " , preferredStyle: .alert)
                            
                            let okAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: { (result) in
                                 self.dismiss(animated: true, completion: nil)
                                 self.navigationController?.pushViewController(loginPage, animated: true)
                            })
                            
                            okAlarm.addAction(okAlertAction)
                            self.present(okAlarm, animated: true, completion: nil)
                       
                        }
                        
                    }else{
                        
                        DispatchQueue.main.async {
                            let RepetitiousAlarm = UIAlertController.init(title: "اشتراک", message: "این ایمیل قبلا ثبت شده است", preferredStyle: .alert)
                            let RepetitiousAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
                            RepetitiousAlarm.addAction(RepetitiousAlertAction)
                            self.present(RepetitiousAlarm, animated: true, completion: nil)

                        }
                       
                        print("errooor")
                        
                    }
                    
                }
                
                
            }
         
            
            
        }else{
            
            let passAlarm = UIAlertController.init(title: "رمز عبور", message: "رمز عبور و تکرار آن یکسان نیست", preferredStyle: .alert)
            let passAlertAction = UIAlertAction.init(title: "باشه", style: .cancel, handler: nil)
            passAlarm.addAction(passAlertAction)
            self.present(passAlarm, animated: true, completion: nil)
            
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

//
//  apiHandler.swift
//  ToDo
//
//  Created by Work on 5/13/19.
//  Copyright © 2019 Kian. All rights reserved.
//

import UIKit

class apiHandler: UITableViewCell {
    var registerinfo = RegisterHandler()
    var LoginInfo = LoginHandler()
    var GroupInfo = GroupHandler()
    var TaskInfo = TaskHandler()
    var plistManager = PlistHandler()
    var sandboxManager = SandboxHandler()
    

    
     func loginManager(info : [String:String] , state : @escaping (Bool) -> Void )  {
       
        guard let loginUrl = URL.init(string: "http://buzztaab.com:8081/api/login") else {return }
        var loginReq = URLRequest.init(url: loginUrl)
        loginReq.httpMethod = "POST"
        loginReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let loginHTTPBody = try? JSONSerialization.data(withJSONObject: info, options: [])
        loginReq.httpBody = loginHTTPBody
        
        URLSession.shared.dataTask(with: loginReq) { (data, response, error) in
            
            if let data = data {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    if let json = json {
                        
                        self.LoginInfo.code = json["code"] as? Int
                        self.LoginInfo.message = json["message"] as? String
                       // print(self.LoginInfo.message!)
                        
                    }else {
                        
                        print("json parser error")
                    }
                    
                    if self.LoginInfo.code == 200 {
                        
                        let body = json?["body"] as! [String:Any]
                        self.LoginInfo.email = body["email"]! as? String
                        self.LoginInfo.first_name = body["first_name"]! as? String
                        self.LoginInfo.last_name = body["last_name"]! as? String
                       // print(self.LoginInfo.first_name!)
                        self.plistManager.plistWriter(name: "token.plist", data: ["name":self.LoginInfo.first_name!])
                        self.plistManager.plistWriter(name: "token.plist", data: ["lname":self.LoginInfo.last_name!])
                        state(true)
                      
                        if let response = response {
                            
                    
                            let responsBody = response as? HTTPURLResponse
                            let header = responsBody?.allHeaderFields
                            let token = header?["token"] as! String
                            self.plistManager.plistWriter(name: "token.plist", data: ["token":token])
                          
                        }else{
                            
                            print("response is not valid")
                            
                        }
                        
                    }else{
                        
                        state(false)
                        print("user and pass is incorect")
                        
                    }
                }catch let error {
                    
                    print("Error : data parser : \(error)")
                    
                }
            }else {
                
                print("data is not valid")
                
            }
        }.resume()
        
    }
    
    
    func registerManager (info : [String:String] ,  state : @escaping (Bool) -> Void  ){
        
        
        guard let registerUrl = URL.init(string: "http://buzztaab.com:8081/api/register") else {return}
        var registerReq = URLRequest.init(url: registerUrl)
        registerReq.httpMethod = "POST"
        registerReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let registerHTTPBody = try? JSONSerialization.data(withJSONObject: info, options: [])
        registerReq.httpBody = registerHTTPBody
        
        URLSession.shared.dataTask(with: registerReq) { (data, response, error) in
            
            if let data = data {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    if let json = json {
                        
                        self.registerinfo.code = json["code"] as? Int
                        self.registerinfo.message = json["message"] as? String
                        print(self.registerinfo.message!)
                        
                    }else {
                        
                        print("json parser error")
                    }
                    if self.registerinfo.code == 200 {
                        
                        let body = json?["body"] as! [String:Any]
                        self.registerinfo.email = body["email"]! as? String
                        self.registerinfo.first_name = body["first_name"]! as? String
                        self.registerinfo.last_name = body["last_name"]! as? String
                        
                        print("register OK")
                        state(true)
                        
                    }else{
                        
                        print("Register ERORR")
                        state(false)
                        
                    }
                }catch let error {
                    
                    print("Error : data parser : \(error)")
                    
                }
            }else {
                
                print("data is not valid")
                
            }
            }.resume()
        

        
    }
    
    func createGroupManager (info : [String:String]  ,  state : @escaping (Bool) -> Void ) {
        
        guard let createGroupUrl = URL.init(string: "http://buzztaab.com:8081/api/createGroup/") else {return}
        var createGroupReq = URLRequest.init(url: createGroupUrl)
        createGroupReq.httpMethod = "POST"
        
        createGroupReq.addValue( "Bearer \(plistManager.readToken(name: "token.plist"))", forHTTPHeaderField:"authorization" )
        createGroupReq.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let createGroupHTTPBody = try? JSONSerialization.data(withJSONObject: info, options: [])
        createGroupReq.httpBody = createGroupHTTPBody
        
        URLSession.shared.dataTask(with: createGroupReq) { (data, response, error) in
            
            if let data = data {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    if let json = json {
                        
                        self.GroupInfo.code = json["code"] as? Int
                        self.GroupInfo.message = json["message"] as? String
                        print(self.GroupInfo.message!)
                        
                    }else {
                        
                        print("json parser error")
                    }
                    
                    if self.GroupInfo.code == 200 {
                        
                        let body = json?["body"] as! [String:Any]
                        self.GroupInfo.id = body["id"]! as? Int
                        self.GroupInfo.name = body["name"]! as? String
                        state(true)
                
                        print("Create OK")
                        
                    }else{
                        state(false)
                        print("Create ERORR")
                        
                    }
                }catch let error {
                    
                    print("Error : data parser : \(error)")
                    
                }
            }else {
                
                print("data is not valid")
                
            }
            }.resume()
        
    }
    
    func deleteGroupManager(info : [String:String] ,  state : @escaping (Bool) -> Void )  {
        
        guard let deleteGroupUrl = URL.init(string: "http://buzztaab.com:8081/api/deleteGroup/") else {return}
        var deleteGroupReq = URLRequest.init(url: deleteGroupUrl)
        deleteGroupReq.httpMethod = "POST"
        deleteGroupReq.addValue( "Bearer \(plistManager.readToken(name: "token.plist"))", forHTTPHeaderField:"authorization" )
        deleteGroupReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let deleteGroupHTTPBody = try? JSONSerialization.data(withJSONObject: info, options: [])
        deleteGroupReq.httpBody = deleteGroupHTTPBody
        
        URLSession.shared.dataTask(with: deleteGroupReq) { (data, response, error) in
            
            if let data = data {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    if let json = json {
                        
                        self.GroupInfo.code = json["code"] as? Int
                        self.GroupInfo.message = json["message"] as? String
                        print(self.GroupInfo.message!)
                        
                    }else {
                        
                        print("json parser error")
                    }
                    
                    if self.GroupInfo.code == 200 {
                        
                    state(true)
                        print("Delete GP OK")
                        
                    }else{
                        state(false)
                        print("Delete GP ERORR")
                        
                    }
                }catch let error {
                    
                    print("Error : data parser : \(error)")
                    
                }
            }else {
                
                print("data is not valid")
                
            }
            }.resume()
        
    }
    
    func updateGroupManager(info : [String:String] ,  state : @escaping (Bool) -> Void ){
        
        guard let updateGroupUrl = URL.init(string: "http://buzztaab.com:8081/api/updateGroup/") else {return}
        var updateGroupReq = URLRequest.init(url: updateGroupUrl)
        updateGroupReq.httpMethod = "POST"
        updateGroupReq.addValue( "Bearer \(plistManager.readToken(name: "token.plist"))", forHTTPHeaderField:"authorization" )
        updateGroupReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let updateGroupHTTPBody = try? JSONSerialization.data(withJSONObject: info, options: [])
        updateGroupReq.httpBody = updateGroupHTTPBody
        
        URLSession.shared.dataTask(with: updateGroupReq) { (data, response, error) in
            
            if let data = data {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    if let json = json {
                        
                        self.GroupInfo.code = json["code"] as? Int
                        self.GroupInfo.message = json["message"] as? String
                        print(self.GroupInfo.message!)
                        
                    }else {
                        
                        print("json parser error")
                    }
                    
                    if self.GroupInfo.code == 200 {
                        
                        let body = json?["body"] as! [String:Any]
                        self.GroupInfo.id = body["id"]! as? Int
                        self.GroupInfo.name = body["name"]! as? String
                        state(true)
                        print("update GP OK")
                        
                    }else{
                        state(false)
                        print("update GP ERORR")
                        
                    }
                }catch let error {
                    
                    print("Error : data parser : \(error)")
                    
                }
            }else {
                
                print("data is not valid")
                
            }
            }.resume()
        
    }
    
    func getGroupManager (info : [String:String] , completion: @escaping ([[String:Any]]) -> Void) {
        
        guard let getGroupUrl = URL.init(string: "http://buzztaab.com:8081/api/getGroup/") else {return}
        var getGroupReq = URLRequest.init(url: getGroupUrl)
        getGroupReq.httpMethod = "POST"
        getGroupReq.addValue( "Bearer \(plistManager.readToken(name: "token.plist"))", forHTTPHeaderField:"authorization" )
        getGroupReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let getGroupHTTPBody = try? JSONSerialization.data(withJSONObject: info, options: [])
        
        getGroupReq.httpBody = getGroupHTTPBody
        
        URLSession.shared.dataTask(with: getGroupReq) { (data, response, error) in
            
            if let data = data {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    if let json = json {
                        
                        self.GroupInfo.code = json["code"] as? Int
                        self.GroupInfo.message = json["message"] as? String
                        print(self.GroupInfo.message!)
                        
                    }else {
                        
                        print("json parser error")
                    }
                    
                    if self.GroupInfo.code == 200 {
                        
                        let body = json?["body"] as! [[String:Any]]
                        completion(body)
                        // gp numbers : print(body.count)
                         //print(body[0]["name"]!)
                        
                        print("get group OK")
                        
                    }else{
                        
                        print("get group ERORR")
                        
                    }
                }catch let error {
                    
                    print("Error : data parser : \(error)")
                    
                }
            }else {
                
                print("data is not valid")
                
            }
            }.resume()
        
    }
    
    func createTaskManager (info : [String:String] , state : @escaping (Bool) -> Void ) {
        
        guard let createTaskUrl = URL.init(string: "http://buzztaab.com:8081/api/createTask/") else {return}
        var createTaskReq = URLRequest.init(url: createTaskUrl)
        createTaskReq.httpMethod = "POST"
        createTaskReq.addValue( "Bearer \(plistManager.readToken(name: "token.plist"))", forHTTPHeaderField:"authorization" )
        createTaskReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let createTaskHTTPBody = try? JSONSerialization.data(withJSONObject: info, options: [])
        createTaskReq.httpBody = createTaskHTTPBody
        
        URLSession.shared.dataTask(with: createTaskReq) { (data, response, error) in
            
            if let data = data {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    if let json = json {
                        
                        self.TaskInfo.code = json["code"] as? Int
                        self.TaskInfo.message = json["message"] as? String
                        print(self.TaskInfo.message!)

                    }else {
                        
                        print("json parser error")
                    }
                    
                    if self.TaskInfo.code == 200 {
                        
                        let body = json?["body"] as! [String:Any]
                        self.TaskInfo.id = body["id"]! as? String
                        self.TaskInfo.taskName = body["taskName"]! as? String
                        print(self.TaskInfo.taskName!)
                        state(true)
                        
                        
                        print("Tasl Create OK")
                        
                    }else{
        
                        state(false)
                        print("Create ERORR")
                        
                    }
                }catch let error {
                    
                    print("Error : data parser : \(error)")
                    
                }
            }else {
                
                print("data is not valid")
                
            }
            }.resume()
        
    }
    
    
    func deleteTaskManager(info : [String:String], state : @escaping (Bool) -> Void ){
        
        guard let deleteTaskUrl = URL.init(string: "http://buzztaab.com:8081/api/deleteTask/") else {return}
        var deleteTaskReq = URLRequest.init(url: deleteTaskUrl)
        deleteTaskReq.httpMethod = "POST"
        deleteTaskReq.addValue( "Bearer \(plistManager.readToken(name: "token.plist"))", forHTTPHeaderField:"authorization" )
        deleteTaskReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let deleteTaskHTTPBody = try? JSONSerialization.data(withJSONObject: info, options: [])
        deleteTaskReq.httpBody = deleteTaskHTTPBody
        
        URLSession.shared.dataTask(with: deleteTaskReq) { (data, response, error) in
            
            if let data = data {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    if let json = json {
                        
                        self.TaskInfo.code = json["code"] as? Int
                        self.TaskInfo.message = json["message"] as? String
                        print(self.TaskInfo.message!)
                        
                    }else {
                        
                        print("json parser error")
                    }
                    
                    if self.TaskInfo.code == 200 {
                        
                        state(true)
                        print("Delete Task OK")
                        
                    }else{
                        state(false)
                        print("Delete Task ERORR")
                        
                    }
                }catch let error {
                    
                    print("Error : data parser : \(error)")
                    
                }
            }else {
                
                print("data is not valid")
                
            }
            }.resume()
        
    }
    
    
    func getTaskManager (info : [String:String] , completion: @escaping ([[String:Any]]) -> Void) {
        
        guard let getTaskUrl = URL.init(string : "http://buzztaab.com:8081/api/getTask/") else {return}
        var getTaskReq = URLRequest.init(url: getTaskUrl)
        getTaskReq.httpMethod = "POST"
        getTaskReq.addValue( "Bearer \(plistManager.readToken(name: "token.plist"))", forHTTPHeaderField:"authorization" )
        getTaskReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let getTaskHTTPBody = try? JSONSerialization.data(withJSONObject: info, options: [])
        
        getTaskReq.httpBody = getTaskHTTPBody
        
        URLSession.shared.dataTask(with: getTaskReq) { (data, response, error) in
            
            if let data = data {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    if let json = json {
                        
                        self.TaskInfo.code = json["code"] as? Int
                        self.TaskInfo.message = json["message"] as? String
                        print(self.TaskInfo.message!)
                        
                    }else {
                        
                        print("json parser error")
                    }
                    
                    if self.TaskInfo.code == 200 {
                        
                        let body = json?["body"] as! [[String:Any]]
                        completion(body)
                        // gp numbers : print(body.count)
                        //print(body[0]["taskName"]!)
                        
                        print("get task OK")
                        
                    }else{
                        
                        print("get task ERORR")
                        
                    }
                }catch let error {
                    
                    print("Error : data parser : \(error)")
                    
                }
            }else {
                
                print("data is not valid")
                
            }
            }.resume()
        
    }
    
    
    func updateTaskManager(info : [String:Any], state : @escaping (Bool) -> Void ){
        
        guard let updateTaskUrl = URL.init(string: "http://buzztaab.com:8081/api/updateTask/") else {return}
        var updateTaskReq = URLRequest.init(url: updateTaskUrl)
        updateTaskReq.httpMethod = "POST"
        updateTaskReq.addValue( "Bearer \(plistManager.readToken(name: "token.plist"))", forHTTPHeaderField:"authorization" )
        updateTaskReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let updateTaskHTTPBody = try? JSONSerialization.data(withJSONObject: info, options: [])
        updateTaskReq.httpBody = updateTaskHTTPBody
        
        URLSession.shared.dataTask(with: updateTaskReq) { (data, response, error) in
            
            if let data = data {
                
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                    if let json = json {
                        
                        self.TaskInfo.code = json["code"] as? Int
                        self.TaskInfo.message = json["message"] as? String
                        print(self.TaskInfo.message!)
                        
                    }else {
                        
                        print("json parser error")
                    }
                    
                    if self.TaskInfo.code == 200 {
                        
                        let body = json?["body"] as! [String:Any]
                        self.TaskInfo.id = body["id"]! as? String
                        self.TaskInfo.taskName = body["taskName"]! as? String
                        
                        print("update task OK")
                        state(true)
                        
                    }else{
                        
                        state(false)
                        print("update task ERORR")
                        
                    }
                }catch let error {
                    
                    print("Error : data parser : \(error)")
                    
                }
            }else {
                
                print("data is not valid")
                
            }
            }.resume()
        
    }
    
    
    
    

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

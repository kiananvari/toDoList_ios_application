//
//  PlistManager.swift
//  chachePlist
//
//  Created by Work on 4/18/19.
//  Copyright © 2019 Kian Anvari. All rights reserved.
//


import Foundation
class PlistHandler{
    
    let sandboxManager = SandboxHandler()
    
      func plistWriter(name : String , data : [String : String]){
        
        sandboxManager.writeToSandBoxIfNeeded(fileNames: name)
        
        let url = sandboxManager.getSandBoxPath().appendingPathComponent(name)
        let myDict = NSMutableDictionary.init(contentsOf: url)
        
        var keys = Array(data.keys)
        var values = Array(data.values)
        
        for item in 0...data.count-1 {
            
            myDict?.setValue(values[item], forKey: keys[item])
            
            
        }
        
  myDict?.write(to: url, atomically: true)
        
    }
    
    
      func plistReader(name : String) -> NSMutableDictionary {
        
        let url = sandboxManager.getSandBoxPath().appendingPathComponent(name)
        let myDict = NSMutableDictionary.init(contentsOf: url)
        
        return myDict!
       }
    
    
    func readToken (name : String) -> String {
      
        let myList = plistReader(name: name)
        var values = myList.allValues
        
        return values[1] as! String
        
    }
    

    }


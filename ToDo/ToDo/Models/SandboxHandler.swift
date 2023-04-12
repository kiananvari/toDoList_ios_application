//
//  SandboxHandler.swift
//  chachePlist
//
//  Created by Work on 4/18/19.
//  Copyright © 2019 Kian Anvari. All rights reserved.
//

import Foundation

class SandboxHandler {
    
    
    func writeToSandBoxIfNeeded (fileNames:String...) {
        
        func getPlistPath (strName:String) -> String {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentDirectory = path[0]
            return documentDirectory.appending("/\(strName)")
        }
        
        let fileManager = FileManager.default
        for index in 0...(fileNames.count) - 1 {
            let myFilePath = getPlistPath(strName: fileNames[index])
            let success = fileManager.fileExists(atPath: getPlistPath(strName: fileNames[index]))
            if !success {
                let defautPath = Bundle.main.resourcePath?.appending("/\(fileNames[index])")
                do{
                    try fileManager.copyItem(atPath: defautPath!, toPath: myFilePath)
                }catch let error as NSError {
                    print("can not copy in new path : \(error)")
                }
            }
        }
    }
    
    
     func getSandBoxPath() -> URL{
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return paths
    }

    
}

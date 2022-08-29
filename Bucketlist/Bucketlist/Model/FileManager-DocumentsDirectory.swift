//
//  FileManager-DocumentsDirectory.swift
//  Bucketlist
//
//  Created by Júlia on 29/8/22.
//

import Foundation


extension FileManager {
    
    //Returns the url of the documentsDirectory of the App
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

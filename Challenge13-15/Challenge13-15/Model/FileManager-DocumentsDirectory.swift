//
//  FileManager-DocumentsDirectory.swift
//  Challenge13-15
//
//  Created by Júlia on 31/8/22.
//

import Foundation

extension FileManager {
    
    //Returns the url of the documentsDirectory of the App
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func saveImage(image: Data) -> String? {
        //we create new url for every new image
        let url = FileManager.documentsDirectory.appendingPathComponent(UUID().uuidString)
        
        do {
            try image.write(to: url, options: [.atomic, .completeFileProtection])
            return url.lastPathComponent
        } catch let error {
            print("Error saving image: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    static func getImage(imagePath: String?) -> Data? {
        //path might be nil.
        guard let imagePath = imagePath else { return nil }
        
        let url = FileManager.documentsDirectory.appendingPathComponent(imagePath)
        if let image = try? Data(contentsOf: url) {
            return image
        }
        
        return nil
        
    }
    
    static func deleteImage(imagePath: String?) {
        guard let imagePath = imagePath else { return }
        
        do {
            let url = FileManager.documentsDirectory.appendingPathComponent(imagePath)
            try FileManager.default.removeItem(at: url)
        } catch let error {
            print("Error deleting image: \(error.localizedDescription)")
        }

    }

}

//
//  ImageSaver.swift
//  Challenge13-15
//
//  Created by Júlia on 31/8/22.
//

import Foundation
import UIKit

class ImageSaver: NSObject {
    //To handle error or success of the saving
    var successHandler: (()->Void)?
    var errorHandler: ((Error)->Void)?
    
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
        
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
        
    }
}

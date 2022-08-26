//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Júlia on 26/8/22.
//

import Foundation
import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
        
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
           print("Save finished!")
       }
}

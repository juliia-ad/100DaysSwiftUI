//
//  ImagePicker.swift
//  Challenge13-15
//
//  Created by Júlia on 31/8/22.
//

import SwiftUI
import PhotosUI

import Foundation

struct ImagePicker: UIViewControllerRepresentable {
    
    /*enum ImageSourceType {
        case camera, library
    }*/

    @Binding var image: UIImage?
    
    //var sourceType: ImageSourceType = .library
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images //we specify the picker is of images
        
        let picker = PHPickerViewController(configuration: config)  //creates the viewController of the picker
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        //
    }
    
    //We specify the coordinator of the ImagePicker: any time something happens inside the photo picker controller, it will report that action to our coordinator
    /* SwiftUI calls it automatically when an instance of ImagePicker is created
     When SwiftUI calls makeUIViewController() and updateUIViewController() it will automatically pass that coordinator object to us.
     */
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            //exit if no selection was made
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
        
    }

    
    
}

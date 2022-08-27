//
//  Test.swift
//  Instafilter
//
//  Created by Júlia on 27/8/22.
//

import Foundation

import CoreImage
import CoreImage.CIFilterBuiltins

import SwiftUI

struct Test: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker = true
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else {
                    return
                }
                
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in
            loadImage()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        
        image = Image(uiImage: inputImage)

    }
    
    
    
    //FUNCTION that loads the current image + applies some filters
  /*  func loadImage() {
        guard let inputImage = UIImage(named: "example") else { return }    //Cogemos la imagen en UIIMage
        let beginImage = CIImage(image: inputImage) //Obtenemos CIImage de la UIIMage
        
        let context = CIContext()
        let currentFilter = CIFilter.twirlDistortion()
        
        currentFilter.inputImage = beginImage
        //currentFilter.radius = 1000
        //currentFilter.center = CGPoint(x: inputImage.size.width/2 , y: inputImage.size.height/2)
        
        let amount = 1.0
        
        //each of the adjustment values are sent in only if they are supported.
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
        }
        
        
        //Get new CIImage
        guard let outputImage = currentFilter.outputImage else { return }
        //Use context to convert CIImage to CGImage
        if let cgimage = context.createCGImage(outputImage, from: outputImage.extent) {
            //Get UIImage from CGImage
            let uiimage = UIImage(cgImage: cgimage)
            //Convert SwiftUI image from UIImage
            image = Image(uiImage: uiimage)
        }
        
    }*/
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}

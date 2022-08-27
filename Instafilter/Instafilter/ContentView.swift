//
//  ContentView.swift
//  Instafilter
//
//  Created by Júlia on 25/8/22.
//

//Needed to use Core Image
import CoreImage
import CoreImage.CIFilterBuiltins

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterScale = 0.5
    @State private var filterRadius = 0.5
    
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select an image")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFill()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                .padding(.bottom)
                
                Group {
                    HStack {
                        Text("Intensity")
                            .foregroundColor(checkInputKey(kCIInputIntensityKey) ? .black : .secondary)
                        Spacer()
                        Slider(value: $filterIntensity, in: 0...1)
                            .frame(width: 300)
                            .disabled(!checkInputKey(kCIInputIntensityKey))
                            .onChange(of: filterIntensity) { _ in   //trigger the upload when filterIntensity changes
                                applyProcessing()
                            }
                    }
                    
                    HStack {
                        Text("Scale")
                            .foregroundColor(checkInputKey(kCIInputScaleKey) ? .black : .secondary)
                        Spacer()
                        Slider(value: $filterScale, in: 0...1)
                            .frame(width: 300)
                            .disabled(!checkInputKey(kCIInputScaleKey))
                            .onChange(of: filterScale) { _ in   //trigger the upload when filterIntensity changes
                                applyProcessing()
                            }
                    }
                    
                    
                    HStack {
                        Text("Radius")
                            .foregroundColor(checkInputKey(kCIInputRadiusKey) ? .black : .secondary)
                        Spacer()
                        Slider(value: $filterRadius, in: 0...1)
                            .frame(width: 300)
                            .disabled(!checkInputKey(kCIInputRadiusKey))
                            .onChange(of: filterRadius) { _ in   //trigger the upload when filterIntensity changes
                                applyProcessing()
                        }
                    }
                }
                
                HStack {
                    Button("Change filter"){
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                        .disabled(image == nil)
                }
                .padding(.top)
            }
            .padding()
            .navigationTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, content: {
                ImagePicker(image: $inputImage)
            })
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet, actions: {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            })
            .onChange(of: inputImage) { _ in
                loadImage()
            }
        }
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success!")
        }
        imageSaver.errorHandler = {
            print("Error: \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)

        
    }
    
    func loadImage(){
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)    //We set the image to the filter
        applyProcessing()

    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
      
    func applyProcessing() {
        //Avoid crashing when the filter doesn't have one of the parameter's filter.
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterScale*10, forKey: kCIInputScaleKey)}
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius*100, forKey: kCIInputRadiusKey)}
        
        
        //CIImage -> CGImage -> UIImage -> SwiftUI Image
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
            
        }
    }
    
    func checkInputKey(_ key: String) -> Bool {
        let inputKeys = currentFilter.inputKeys
        
        return inputKeys.contains(key)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

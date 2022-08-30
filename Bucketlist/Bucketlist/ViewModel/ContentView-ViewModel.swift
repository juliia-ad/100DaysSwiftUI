//
//  ContentView-ViewModel.swift
//  Bucketlist
//
//  Created by Júlia on 29/8/22.
//

import Foundation
import MapKit
import LocalAuthentication

//class that manages our data, and manipulates it on behalf of the ContentView struct so that our view doesn’t really care how the underlying data system works
extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        
        @Published private(set) var locations: [Location]    //We can read it, but only this class itself can write.
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        
        @Published var showingAuthenticationError = false
        @Published var authenticationError = "Unknown error"
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        //Load saved data
        init() {
            do {
                let data = try Data(contentsOf: savePath)   //JSON encoded
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])   //CompleteFileProtection -> ensures we can only access the data if the device is unlocked
            } catch {
                print("Unable to save data")
            }
        }
        
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return } //Make sure selectedPlace != nil
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }

        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    Task { @MainActor in  //Make sure the task runs in the MainActor
                        if success {
                            self.isUnlocked = true
                            
                        } else {
                            self.authenticationError = "Please, try again."
                            self.showingAuthenticationError = true
                        }
                    }
                }
            } else {
                self.authenticationError = "Sorry, your device doesn't support biometric authentication."
                self.showingAuthenticationError = true
            }
        }
        
    }
}

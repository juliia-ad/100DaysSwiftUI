//
//  ContentView.swift
//  Bucketlist
//
//  Created by Júlia on 28/8/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    
    
    var body: some View {
        if vm.isUnlocked {
            ZStack {
                Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            
                            Text(location.name)
                                .fixedSize()    //To avoid adopt the old name frame size (so it doesn't get clipped)
                        }
                        .onTapGesture {
                            vm.selectedPlace = location
                        }
                    }
                }
                .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            vm.addLocation()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                    }
                    
                }
            }
            .sheet(item: $vm.selectedPlace) { place in //SwiftUI unwrapps the optional automatically
                EditView(location: place) {
                    vm.update(location: $0)
                }
            }
        } else {
            Button("Unlock Places"){
                vm.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

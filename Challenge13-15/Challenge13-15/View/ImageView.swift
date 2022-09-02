//
//  ImageView.swift
//  Challenge13-15
//
//  Created by Júlia on 1/9/22.
//

import SwiftUI
import MapKit

struct ImageView: View {
    @State var image: Image?
    @State var mapRegion: MKCoordinateRegion
    @State var contact: Contact

    @State private var showingLocation = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
                .padding(.bottom, 50)
            Spacer()
            
            Section {
                HStack {
                    Image(systemName: showingLocation ? "arrowtriangle.down.fill" : "arrowtriangle.right.fill")
                    Text("See picture Location")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)
                .foregroundColor(.secondary)
                .onTapGesture {
                    showingLocation.toggle()
                }
                
                if showingLocation {
                    Map(coordinateRegion: $mapRegion, annotationItems: [contact]) { _ in
                        MapMarker(coordinate: contact.coordinate)
                    }
                } else {
                    Rectangle()
                        .foregroundColor(.white)
                }
            }
        }
        .navigationTitle(contact.firstName + " " + contact.secondName)
    }
}

/*struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
*/

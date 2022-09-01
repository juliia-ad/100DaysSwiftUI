//
//  ImageView.swift
//  Challenge13-15
//
//  Created by Júlia on 1/9/22.
//

import SwiftUI

struct ImageView: View {
    @State var image: Image?
    
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            Spacer()
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}

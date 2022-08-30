//
//  RatingView.swift
//  Bookworm
//
//  Created by Júlia on 13/8/22.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var label = ""
    
    var maximumRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1...maximumRating, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
                    .accessibilityElement()
                    .accessibilityLabel("rating")
                    .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
                    .accessibilityAdjustableAction { direction in
                        switch direction {
                        case .increment:
                            if rating < maximumRating { rating += 1 }
                        case .decrement:
                            if rating > 1 { rating -= 1 }
                        default:
                            break
                        }
                    } //AdustableAction allows that rating value to be adjusted up or down using swipes, which is better than the individual star images.
                
                
                
                /*
                    .accessibilityLabel("\(number == 1 ? "1 star" : "\(number) stars")")
                    .accessibilityRemoveTraits(.isImage)
                    .accessibilityAddTraits(number > rating ? .isButton : [.isButton, .isSelected]) //We also tell if the star is already selected or not
                */
            }
        }
    }
    
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}

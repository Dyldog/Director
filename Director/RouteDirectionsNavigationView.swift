//
//  RouteDirectionsNavigationView.swift
//  Director
//
//  Created by Dylan Elliott on 11/7/2024.
//

import SwiftUI

struct RouteDirectionsNavigationView: View {
    let directions: Directions
    @Binding var currentStep: Int
    
    var currentDirection: String { directions.steps[currentStep] }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.background)
            
            VStack {
                Spacer()
                Text(currentDirection)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.1)
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
                Text("\(currentStep.userFriendly) of \(directions.steps.count)")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
        }
        .gesture(TapGesture(count: 2)
            .onEnded {
                currentStep = (currentStep - 1 + directions.steps.count) % directions.steps.count
            }
            .exclusively(
                before: TapGesture().onEnded {
                    currentStep = (currentStep + 1) % directions.steps.count
                }
            )
        )
    }
}

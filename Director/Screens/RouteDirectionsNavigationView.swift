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
        VStack {
            Spacer()
            Text(currentDirection)
                .font(.massive)
                .minimumScaleFactor(0.1)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
            Text("\(currentStep.userFriendly) of \(directions.steps.count)")
                .font(.footnote)
                .foregroundStyle(.gray)
        }
        .oneTwoTapGesture {
            currentStep = (currentStep + 1) % directions.steps.count
        } onTwo: {
            currentStep = (currentStep - 1 + directions.steps.count) % directions.steps.count
        }
    }
}

extension View {
    var tappableBackground: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.background)
            self
        }
    }
}

extension View {
    func oneTwoTapGesture(onOne: @escaping () -> Void, onTwo: @escaping () -> Void) -> some View {
        gesture(TapGesture(count: 2)
            .onEnded {
                onTwo()
            }
            .exclusively(
                before: TapGesture().onEnded {
                    onOne()
                }
            )
        )
    }
}

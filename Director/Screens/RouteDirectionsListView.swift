//
//  RouteDirectionsListView.swift
//  Director
//
//  Created by Dylan Elliott on 11/7/2024.
//

import SwiftUI

struct RouteDirectionsListView: View {
    let directions: Directions
    
    var body: some View {
        List(directions.steps.enumeratedArray(), id: \.offset) { index, direction in
            HStack(alignment: .top) {
                Text("\(index.userFriendly).")
                    .font(.title)
                Text(direction)
                    .font(.title)
            }
        }
        .listStyle(.plain)
    }
}

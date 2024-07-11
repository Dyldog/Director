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
        List(directions.steps.enumeratedArray(), id: \.offset) { _, direction in
            Text(direction)
        }
    }
}

//
//  RouteDirectionsView.swift
//  Director
//
//  Created by Dylan Elliott on 11/7/2024.
//

import SwiftUI

struct RouteDirectionsView: View {
    let directions: Directions
    @State var mode: Mode = .navigation
    @State var currentStep: Int = 0
    
    var iconForMode: String {
        switch mode {
        case .navigation: "list.bullet.clipboard"
        case .list: "map"
        }
    }
    var body: some View {
        Group {
            switch mode {
            case .navigation: RouteDirectionsNavigationView(directions: directions, currentStep: $currentStep)
            case .list: RouteDirectionsListView(directions: directions)
            }
        }
        .navigationTitle(directions.title)
        .toolbar {
            Button(systemIcon: iconForMode) {
                switch mode {
                case .list: mode = .navigation
                case .navigation: mode = .list
                }
            }
        }
    }
}

extension RouteDirectionsView {
    enum Mode {
        case navigation
        case list
    }
}

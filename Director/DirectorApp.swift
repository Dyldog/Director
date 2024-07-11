//
//  DirectorApp.swift
//  Director
//
//  Created by Dylan Elliott on 11/7/2024.
//

import SwiftUI

@main
struct DirectorApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                DirectionsListView()
            }
        }
    }
}

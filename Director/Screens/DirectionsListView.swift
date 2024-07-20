//
//  DirectionsListView.swift
//  Director
//
//  Created by Dylan Elliott on 11/7/2024.
//

import SwiftUI

struct DirectionsListView: View {
    @Environment(DirectionsManager.self) var manager: DirectionsManager
    @State private var detailDirectionSet: Directions?
    @State private var showMap: MapViewMode?

    var body: some View {
        List(manager.directions) { directionSet in
            row(with: directionSet)
        }
        .navigationTitle("Directions")
        .navigationDestination(for: Directions.self) { directionSet in
            detailView(for: directionSet)
        }
        .navigationDestination(for: $showMap) { mapMode in
            mapView(for: mapMode)
        }
        .toolbar {
            Button(systemIcon: "plus") {
                showMap = .create
            }
        }
    }

    // MARK: Views

    @ViewBuilder
    private func row(with directionSet: Directions) -> some View {
        NavigationLink(value: directionSet) {
            VStack(alignment: .leading) {
                Text(directionSet.title)
                    .font(.title.bold())
                Text("\(directionSet.steps.count) waypoints")
                    .font(.footnote)
            }
        }
        .swipeActions {
            Button(systemIcon: "pencil") {
                showMap = .edit(directionSet.id)
            }
            .tint(.green)

            Button(systemIcon: "trash") {
                manager.deleteDirections(with: directionSet.id)
            }
            .tint(.red)
        }
    }

    @ViewBuilder
    private func mapView(for mode: MapViewMode) -> some View {
        RouteMapView(
            title: manager.directions(for: mode.editID)?.title ?? .randomString(length: 5).uppercased(),
            directions: manager.directions(for: mode.editID)?.steps ?? []
        ) { newTitle, newDirections in
            switch mode {
            case .create: manager.createNewDirections(with: newTitle, and: newDirections)
            case let .edit(id): manager.updateExistingDirections(with: id, title: newTitle, and: newDirections)
            }

            showMap = nil
        }
    }

    @ViewBuilder
    private func detailView(for directionSet: Directions) -> some View {
        RouteDirectionsView(directions: directionSet)
    }
}

private extension DirectionsListView {
    enum MapViewMode {
        case create
        case edit(UUID)

        var editID: UUID? {
            switch self {
            case let .edit(id): id
            default: nil
            }
        }
    }
}

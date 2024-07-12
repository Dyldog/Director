//
//  RouteListView.swift
//  Director
//
//  Created by Dylan Elliott on 11/7/2024.
//

import SwiftUI

struct Directions: Identifiable, Hashable, Codable {
    let id: UUID
    let title: String
    let steps: [String]
    
    init(id: UUID, title: String, steps: [String]) {
        self.id = id
        self.title = title
        self.steps = steps
    }
}

struct DirectionsListView: View {
    @State var directions: [Directions]
    
    @State private var detailDirectionSet: Directions?
    @State private var showMap: MapViewMode? = nil
    
    private func directions(for id: UUID?) -> Directions? {
        guard let id else { return nil }
        return directions.first { $0.id == id }
    }
    
    init() {
        _directions = .init(initialValue: Self.getSavedDirections())
    }
    
    var body: some View {
        List(directions) { directionSet in
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
                deleteDirections(with: directionSet.id)
            }
            .tint(.red)
        }
    }
    
    @ViewBuilder
    private func mapView(for mode: MapViewMode) -> some View {
        RouteMapView(
            title: directions(for: mode.editID)?.title ?? .randomString(length: 5).uppercased(),
            directions: directions(for: mode.editID)?.steps ?? []
        ) { newTitle, newDirections in
            switch mode {
            case .create: createNewDirections(with: newTitle, and: newDirections)
            case let .edit(id): updateExistingDirections(with: id, title: newTitle, and: newDirections)
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

// MARK: - Updating Directions

private extension DirectionsListView {
    func createNewDirections(with title: String, and steps: [String]) {
        directions.append(.init(
            id: .init(),
            title: title,
            steps: steps
        ))
        Self.saveDirections(directions)
    }
    
    func updateExistingDirections(with id: UUID, title: String, and steps: [String]) {
        guard let index = directions.firstIndex(where: { $0.id == id }) else { return }
        let oldDirections = directions[index]
        directions[index] = .init(
            id: id,
            title: title,
            steps: steps
        )
        Self.saveDirections(directions)
    }
    
    func deleteDirections(with id: UUID) {
        guard let index = directions.firstIndex(where: { $0.id == id }) else { return }
        directions.remove(at: index)
        Self.saveDirections(directions)
    }
}

// MARK: - Data Persistence

private extension DirectionsListView {
    static func getSavedDirections() -> [Directions] {
        do {
            return try UserDefaults.standard.value(for: UserDefaultsKeys.directions)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    static func saveDirections(_ newDirections: [Directions]) {
        // TODO: Show error to user
        do {
            try UserDefaults.standard.set(newDirections, for: UserDefaultsKeys.directions)
            UserDefaults.standard.synchronize()
        } catch {
            print(error.localizedDescription)
        }
    }
}

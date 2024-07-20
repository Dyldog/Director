//
//  DirectionsManager.swift
//  Director
//
//  Created by Dylan Elliott on 11/7/2024.
//

import Observation
import SwiftUI

@Observable
class DirectionsManager {
    private(set) var directions: [Directions]

    init() {
        directions = Self.getSavedDirections()
    }

    func directions(for id: UUID?) -> Directions? {
        guard let id else { return nil }
        return directions.first { $0.id == id }
    }
}

// MARK: - Updating Directions

extension DirectionsManager {
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

private extension DirectionsManager {
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

//
//  Directions.swift
//  Director
//
//  Created by Dylan Elliott on 11/7/2024.
//

import Foundation

struct Directions: Identifiable, Hashable, Codable {
    let id: UUID
    let title: String
    let steps: [String]
}

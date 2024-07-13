//
//  IDWrappable.swift
//  Director
//
//  Created by Dylan Elliott on 12/7/2024.
//

import Foundation

struct IDWrapper<T>: Identifiable {
    let id: UUID
    let value: T
    
    init(id: UUID = .init(), value: T) {
        self.id = id
        self.value = value
    }
}

protocol IDWrappable { }

extension IDWrappable {
    var identifiable: IDWrapper<Self> {
        IDWrapper(value: self)
    }
}

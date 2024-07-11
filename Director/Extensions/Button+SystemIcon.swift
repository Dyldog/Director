//
//  Button+SystemIcon.swift
//  Director
//
//  Created by Dylan Elliott on 11/7/2024.
//

import SwiftUI

extension Button {
    init(systemIcon: String, action: @escaping () -> Void) where Label == Image {
        self.init(action: action, label: {
            Image(systemName: systemIcon)
        })
    }
}

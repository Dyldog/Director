//
//  DirectionsWritingSheet.swift
//  Director
//
//  Created by Dylan Elliott on 11/7/2024.
//

import SwiftUI

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

struct DirectionsWritingSheet: View {
    @State var textEditorHeight : CGFloat = 0

    @Binding var directions: [String]
    @State var currentDirectionIndex: Int = 0
    
    var currentDirection: Binding<String> {
        .init {
            directions[currentDirectionIndex]
        } set: {
            directions[currentDirectionIndex] = $0
        }

    }
    
    var body: some View {
        VStack(spacing: 12) {
            buttonBar
            textField
        }
        .padding(.horizontal)
        .padding(.top)
        .padding(.bottom, 0)
    }
    
    private var buttonBar: some View {
        HStack {
            Button(systemIcon: "plus") {
                directions.insert("", at: currentDirectionIndex + 1)
                currentDirectionIndex += 1
            }
            
            Text("\(currentDirectionIndex.userFriendly) of \(directions.count)")
            
            Spacer()
            
            Button(systemIcon: "arrow.left") {
                currentDirectionIndex = max(currentDirectionIndex - 1, 0)
            }
            .foregroundStyle(.blue)
            
            Button(systemIcon: "arrow.right") {
                currentDirectionIndex = min(currentDirectionIndex + 1, directions.lastIndex ?? 0)
            }
            .foregroundStyle(.blue)
        }
    }
    
    private var textField: some View {
        // Text editor is going behind keyboard for some reason
//            TextEditor(text: currentDirection)
//                .fixedSize(horizontal: false, vertical: true)
//                .frame(height: max(40, textEditorHeight))
//                .onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
        HStack {
            TextField("Enter directions...", text: currentDirection)
            
            Button(systemIcon: "xmark") {
                directions.remove(at: currentDirectionIndex)
                
                if currentDirectionIndex >= directions.endIndex {
                    currentDirectionIndex = directions.lastIndex ?? 0
                }
                
                if currentDirectionIndex < 0 {
                    currentDirectionIndex = 0
                }
                
                if directions.isEmpty {
                    directions.append("")
                }
            }
            .foregroundStyle(.red)
        }
    }
}

extension Int {
    var userFriendly: Int { self + 1 }
}

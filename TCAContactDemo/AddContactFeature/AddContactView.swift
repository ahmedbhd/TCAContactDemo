//
//  AddContactView.swift
//  TCAContactDemo
//
//  Created by Anypli M1 Air on 7/12/2023.
//

import SwiftUI
import ComposableArchitecture

struct AddContactView: View {
    let store: StoreOf<AddContactFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                TextField(
                    "Name",
                    text: viewStore.binding(
                        get: \.contact.name,
                        send: { .setName($0)}
                    )
                )
                
                Button("Save") {
                    viewStore.send(.saveButtonTapped)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Cancel") {
                        viewStore.send(.cancelButtonTapped)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddContactView(
            store: Store(
                initialState: AddContactFeature.State(
                    contact: Contact(
                        id: UUID(),
                        name: "blob"
                    )
                )
            ) {
                AddContactFeature()
            }
        )
    }
}

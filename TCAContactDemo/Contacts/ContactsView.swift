//
//  ContactsView.swift
//  TCAContactDemo
//
//  Created by Anypli M1 Air on 7/12/2023.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    
    let store: StoreOf<ContactsFeature>
    
    var body: some View {
        NavigationStack {
            WithViewStore(self.store, observe: \.contacts) { viewStore in
                List {
                    ForEach(viewStore.state) { contact in
                        HStack {
                            Text(contact.name)
                            Spacer()
                            Button {
                                viewStore.send(
                                    .deleteButtonTapped(
                                        id: contact.id
                                    )
                                )
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundStyle(Color.red)
                            }
                        }
                    }
                }
                .navigationTitle("Contacts")
                .toolbar {
                    ToolbarItem {
                        Button {
                            viewStore.send(.addButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .sheet(
            store: self.store.scope(
                state: \.$destination.addContact,
                action: \.destination.addContact
            )
        ) { AddContactStore in
            NavigationStack {
                AddContactView(store: AddContactStore)
            }
        }
        .alert(
            store: self.store.scope(
                state: \.$destination.alert,
                action: \.destination.alert
            )
        )
    }
}

#Preview {
    ContactsView(store: TCAContactDemoApp.store)
}

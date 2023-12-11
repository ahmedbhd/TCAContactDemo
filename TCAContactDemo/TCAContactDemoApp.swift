//
//  TCAContactDemoApp.swift
//  TCAContactDemo
//
//  Created by Anypli M1 Air on 7/12/2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAContactDemoApp: App {
    static let store = Store(
        initialState: ContactsFeature.State(
            contacts: [
                Contact(id: UUID(), name: "Blob"),
                Contact(id: UUID(), name: "Blob Jr"),
                Contact(id: UUID(), name: "Blob Sr"),
            ]
        )
    ) {
        ContactsFeature()
    }
    var body: some Scene {
        WindowGroup {
            ContactsView(store: TCAContactDemoApp.store)
        }
    }
}

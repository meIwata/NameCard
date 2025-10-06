//
//  ContentView.swift
//  NameCard
//
//  Created by Harry Ng on 9/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var navigationPath = NavigationPath()

    var body: some View {
        PeopleListView(navigationPath: $navigationPath)
            .onOpenURL { url in
                handleDeepLink(url)
            }
    }

    private func handleDeepLink(_ url: URL) {
        // Deep link format: namecard://contact/{uuid}
        guard url.scheme == "namecard",
              url.host == "contact" else {
            print("❌ Invalid deep link URL: \(url)")
            return
        }

        // Extract UUID from URL path
        let uuidString = url.lastPathComponent
        guard !uuidString.isEmpty,
              let uuid = UUID(uuidString: uuidString) else {
            print("❌ Invalid UUID in URL: \(url)")
            return
        }

        print("✅ Deep link received: \(uuid)")

        // Find the contact
        let descriptor = FetchDescriptor<StoredContact>(
            predicate: #Predicate { $0.id == uuid }
        )

        do {
            let contacts = try modelContext.fetch(descriptor)
            if let contact = contacts.first {
                print("✅ Found contact: \(contact.fullName)")

                // Clear existing path and navigate to contact
                navigationPath = NavigationPath()

                // First append category if exists, then the contact
                if let category = contact.category {
                    navigationPath.append(category)
                }
                navigationPath.append(contact)
            } else {
                print("❌ Contact not found for ID: \(uuid)")
            }
        } catch {
            print("❌ Error fetching contact: \(error)")
        }
    }
}

#Preview {
    ContentView()
}

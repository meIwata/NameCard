import SwiftUI
import SwiftData
import Charts

struct ContactTrendChart: View {
    let data: [CategoryData]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Contacts by Category")
                .font(.headline)
                .foregroundStyle(.primary)

            if data.isEmpty {
                ContentUnavailableView(
                    "No Category Data",
                    systemImage: "chart.line.uptrend.xyaxis",
                    description: Text("Category distribution will appear here")
                )
                .frame(height: 200)
            } else {
                Chart(data) { item in
                    LineMark(
                        x: .value("Category", item.name),
                        y: .value("Contacts", item.count)
                    )
                    .foregroundStyle(.blue)
                    .symbol(.circle)
                    .interpolationMethod(.catmullRom)
                }
                .frame(height: 200)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct WrappedLineView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var categories: [ContactCategory]
    @Query private var allContacts: [StoredContact]

    var body: some View {
        ContactTrendChart(
            data: allContacts.categoryDistribution(categories: categories)
        )
    }
}

#Preview("Line Chart") {
    WrappedLineView()
        .modelContainer(previewContainer)
}

// Build an in-memory SwiftData container and seed sample data for charts
private let previewContainer: ModelContainer = {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: StoredContact.self, ContactCategory.self,
        configurations: configuration
    )
    let context = container.mainContext

    // Sample categories
    let friends = ContactCategory(name: "Friends", colorHex: "FF3B30")
    let work = ContactCategory(name: "Work", colorHex: "34C759")
    let family = ContactCategory(name: "Family", colorHex: "007AFF")

    context.insert(friends)
    context.insert(work)
    context.insert(family)

    // Sample contacts with dates spread over time to show trend
    let calendar = Calendar.current
    let now = Date()

    let contacts: [StoredContact] = [
        StoredContact(
            firstName: "Alice",
            lastName: "Smith",
            title: "Engineer",
            organization: "Acme Corp",
            email: "alice@acme.com",
            phone: "555-1111",
            address: "1 Infinite Loop, Cupertino, CA",
            website: "https://acme.com",
            department: "R&D",
            category: work,
            dateAdded: calendar.date(byAdding: .day, value: -60, to: now)!
        ),
        StoredContact(
            firstName: "Bob",
            lastName: "Johnson",
            title: "Designer",
            organization: "Freelance",
            email: "",
            phone: "555-2222",
            address: "",
            website: "",
            department: "",
            category: friends,
            dateAdded: calendar.date(byAdding: .day, value: -45, to: now)!
        ),
        StoredContact(
            firstName: "Carol",
            lastName: "Lee",
            title: "Teacher",
            organization: "Springfield High",
            email: "carol.lee@school.edu",
            phone: "",
            address: "123 School St",
            website: "",
            department: "Math",
            category: family,
            dateAdded: calendar.date(byAdding: .day, value: -30, to: now)!
        ),
        StoredContact(
            firstName: "David",
            lastName: "Ng",
            title: "",
            organization: "",
            email: "david@example.com",
            phone: "",
            address: "",
            website: "",
            department: "",
            category: nil,
            dateAdded: calendar.date(byAdding: .day, value: -15, to: now)!
        ),
        StoredContact(
            firstName: "Emma",
            lastName: "Wilson",
            title: "Manager",
            organization: "Tech Co",
            email: "emma@tech.co",
            phone: "555-3333",
            address: "",
            website: "",
            department: "Operations",
            category: work,
            dateAdded: calendar.date(byAdding: .day, value: -7, to: now)!
        ),
        StoredContact(
            firstName: "Frank",
            lastName: "Brown",
            title: "Developer",
            organization: "StartUp Inc",
            email: "frank@startup.com",
            phone: "555-4444",
            address: "",
            website: "",
            department: "Engineering",
            category: work,
            dateAdded: calendar.date(byAdding: .day, value: -2, to: now)!
        )
    ]

    contacts.forEach { context.insert($0) }

    return container
}()

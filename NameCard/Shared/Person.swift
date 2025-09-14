import Foundation
import SwiftUI

enum PersonType: String, CaseIterable {
    case teacher = "Teachers"
    case student = "Students"
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let type: PersonType
    let contact: Contact?
    let nameCard: (() -> AnyView)?
    
    init(name: String, type: PersonType, contact: Contact? = nil, nameCard: (() -> AnyView)? = nil) {
        self.name = name
        self.type = type
        self.contact = contact
        self.nameCard = nameCard
    }
}

extension Person {
    static let sampleData: [Person] = [
        Person(name: "Harry", type: .teacher, contact: Contact.sampleData),
        Person(name: "Leo", type: .student, contact: LeoView.contact, nameCard: { AnyView(LeoView()) }),
    ]
}

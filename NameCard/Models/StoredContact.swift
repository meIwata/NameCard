//
//  StoredContact.swift
//  NameCard
//
//  Created by Guest User on 2025/9/16.
//
import Foundation
import SwiftData

@Model
class StoredContact{
    var id: UUID
    var name: String
    var title: String
    var email: String
    
    // 只能寫在一邊
//    @Relationship(inverse: \ContactCategory.contacts)
    var category: ContactCategory?
    
    init(id: UUID, name: String, title: String, email: String) {
        self.id = id
        self.name = name
        self.title = title
        self.email = email
    }
}

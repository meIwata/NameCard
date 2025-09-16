//
//  ContactCategory.swift
//  NameCard
//
//  Created by Guest User on 2025/9/16.
//
import Foundation
import SwiftData

@Model
class ContactCategory{
    var id: UUID
    var name: String
    
//    當你刪除某一側的物件時，與其關聯的物件，其關聯欄位會被設為 nil（空值）
//    @Relationship(deleteRule: .nullify, inverse:\StoredContact.category)
    
//    當你刪除此關聯物件（例如一個 category），所有與它關聯的 StoredContact 物件也會被「一起刪除」
    @Relationship(deleteRule: .cascade, inverse:\StoredContact.category)
    var contacts:[StoredContact]=[]
    
    var deletedContacts: [StoredContact]=[]
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

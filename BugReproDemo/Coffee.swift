//
//  Coffee.swift
//  BugReproDemo
//
//  Created by Adriano Segalada on 29.01.20.
//  Copyright © 2020 Adriano Segalada. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Coffee: ObservableObject, Identifiable {
    
    @Published var id: String
    @Published var name: String
    @Published var grown: Date

    init(id: String, name: String, grown: Date) {
        self.id = id
        self.name = name
        self.grown = grown
    }
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        if let castedName = document.get("name") as? String {
            self.name = castedName
        } else {
            self.name = "undefined"
        }
        if let castedGrown = document.get("grown") as? Timestamp {
            self.grown = castedGrown.dateValue()
        } else {
            self.grown = Date()
        }
    }

}

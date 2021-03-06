//
//  ContentView.swift
//  BugReproDemo
//
//  Created by Adriano Segalada on 29.01.20.
//  Copyright © 2020 Adriano Segalada. All rights reserved.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    
    let db = Firestore.firestore()
    @State var coffees = [Coffee]()
    
    var body: some View {
    
        return NavigationView {
                List {
                    ForEach(coffees) { coffee in
                        Text(coffee.name)
                    }
                }
                .onAppear {
                    self.addCoffeeListener()
                }
                .navigationBarTitle("Demo")
            }
    }

    func addCoffeeListener() {

        self.db.collectionGroup("coffee").addSnapshotListener { querySnapshot, err in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(err!)")
                return
            }

            // example map over an array with a plain Swift type in it
            // it works!
            let fakeCoffees: [String] = ["Frappuccino", "Tea"]
            self.coffees = fakeCoffees.map { name in
              Coffee(id: name, name: name, grown: Date())
            }

            // The following line causes the "canvas" in Xcode to crash. As soon as we iterate over 'documents'
            // https://github.com/firebase/firebase-ios-sdk/issues/4772
            //self.coffees = documents.map { Coffee(document: $0) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coffees: [Coffee(id: "123", name: "some name", grown: Date())])
    }
}

//
//  AddAuthor.swift
//  Book_SwiftData
//
//  Created by David Grau Beltrán  on 15/03/24.
//

import SwiftUI

struct AddAuthor: View {
    @Environment(ApplicationData.self) private var appData
    @Environment(\.modelContext) var dbContext
    @State private var nameInput: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField("Insert Name", text: $nameInput)
                .textFieldStyle(.roundedBorder)
            HStack {
                Spacer()
                Button("Save") {
                    storeAuthor()
                }.buttonStyle(.borderedProminent)
            }
            Spacer()
        }.padding()
    }
    func storeAuthor() {
        let name = nameInput.trimmingCharacters(in: .whitespaces)
        if !name.isEmpty {
            let newAuthor = Author(name: name, books: [])
            dbContext.insert(newAuthor)
            appData.selectedAuthor = newAuthor
            appData.viewPath.removeLast(2)
        }
    }
}

#Preview {
    NavigationStack {
        AddAuthor()
            .environment(ApplicationData())
            .modelContainer(for: [Book.self, Author.self], inMemory: true)
    }
}

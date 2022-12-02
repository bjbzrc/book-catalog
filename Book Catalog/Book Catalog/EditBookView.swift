// Created by Brandon Buttlar

import SwiftUI

struct EditBookView: View {
    var book: Book
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @State var rating: Int16
    @State var readStatus: Bool
    
    init(book: Book) {
        self.book = book
        _rating = State(initialValue: book.rating)
        _readStatus = State(initialValue: book.status)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Details")) {
                    Stepper("Rating: \(rating) / 5", value: $rating, in: 0...5)
                    Toggle(isOn: $readStatus) {
                        Text("Read")
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {
                        book.rating = Int16(self.rating)
                        book.status = self.readStatus
                        do {
                            try viewContext.save()
                            print("\nBook saved.")
                            presentationMode.wrappedValue.dismiss()
                            } catch {
                                print(error.localizedDescription)
                            }
                    }) {
                        Text("Save Changes")
                    }
                    Spacer()
                }
            }
            .navigationTitle("Edit Book")
            .navigationBarItems(trailing: Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
            }))
        }
    }
}

struct EditBookView_Previews: PreviewProvider {
    static var previews: some View {
        EditBookView(book: EditTestDataProvider().book)
    }
}

struct EditTestDataProvider {
    var book = Book(context: PersistenceController.preview.container.viewContext)
    init() {
        book.title = "Sample Title"
        book.author = "Sample Author"
        book.genre = "Sample Genre"
        book.rating = 3
        book.status = true
        book.summary = "Sample Description"
    }
}

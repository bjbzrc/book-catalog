// Created by Brandon Buttlar

import SwiftUI

struct NewBookView: View {
    let genres = ["Fantasy", "Sci-Fi", "Mystery", "Romance", "Horror", "Fiction", "Nonfiction"]
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @State var title: String = ""
    @State var author: String = ""
    @State var selectedGenreIndex = 0
    @State var rating: Int = 0
    @State var readStatus = false
    @State var summary: String = "\t"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    Picker(selection: $selectedGenreIndex, label: Text("Genre")) {
                        ForEach(0 ..< 7) {
                            Text(self.genres[$0]).tag($0)
                        }
                    }
                    Stepper("Rating: \(rating) / 5", value: $rating, in: 0...5)
                    Toggle(isOn: $readStatus) {
                        Text("Read")
                    }
                    VStack {
                        HStack { Text("Summary:")
                            Spacer() }
                        TextEditor(text: $summary).frame(height: 200)
                            .font(.custom("HelveticaNeue", size: 16))
                            .lineSpacing(5)
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {
                        guard self.title != "" else {return}
                        guard self.author != "" else {return}
                        guard self.summary != "" else {return}
                        let newBook = Book(context: viewContext)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.id = UUID()
                        newBook.summary = self.summary
                        newBook.genre = self.genres[self.selectedGenreIndex]
                        newBook.rating = Int16(self.rating)
                        newBook.status = self.readStatus
                        do {
                            try viewContext.save()
                            print("\nBook saved.")
                            presentationMode.wrappedValue.dismiss()
                            } catch {
                                print(error.localizedDescription)
                            }
                    }) {
                        Text("Add Book")
                    }
                    Spacer()
                }
            }
            .navigationTitle("Add Book")
            .navigationBarItems(trailing: Button(action: {
                dismiss()
            }, label: {
                Text("Cancel")
            }))
        }
    }
}

struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView()
    }
}

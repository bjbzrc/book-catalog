// Created by Brandon Buttlar

import SwiftUI

struct BookDetailView: View {
    var book: Book
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State var showEditBookView = false

    var body: some View {
        VStack {
            HStack {
                VStack(spacing: 5) {
                    HStack {
                        Text("Title:").foregroundColor(Color.gray).font(.system(size: 14))
                        Text(book.title)
                        Spacer()
                    }
                    HStack {
                        Text("Author:").foregroundColor(Color.gray).font(.system(size: 14))
                        Text(book.author)
                        Spacer()
                    }
                    HStack {
                        Text("Genre:").foregroundColor(Color.gray).font(.system(size: 14))
                        Text(book.genre)
                        Spacer()
                    }
                    HStack {
                        Text("Rating:").foregroundColor(Color.gray).font(.system(size: 14))
                        Text("\(book.rating) / 5")
                        Spacer()
                    }
                    HStack {
                        Text("Read:").foregroundColor(Color.gray).font(.system(size: 14))
                        if book.status {
                            Text("Yes")
                        } else {
                            Text("No")
                        }
                        Spacer()
                    }
                    HStack {
                        Text("Summary:").foregroundColor(Color.gray).font(.system(size: 14))
                        Spacer()
                    }
                    HStack {
                        Text(book.summary).font(.custom("HelveticaNeue", size: 16))
                        Spacer()
                    }
                    Spacer()
                }
            }.padding()
        }
        .navigationTitle("Book Details")
        .navigationBarItems(trailing: Button(action: {
            showEditBookView = true
        }, label: {
            Text("Edit")
                .imageScale(.large)
        }))
        .sheet(isPresented: $showEditBookView) {
            EditBookView(book: book)
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BookDetailView(book: TestDataProvider().book)
                .previewInterfaceOrientation(.portrait)
        }
    }
}

struct TestDataProvider {
    var book = Book(context: PersistenceController.preview.container.viewContext)
    init() {
        book.title = "Sample Title"
        book.author = "Sample Author"
        book.genre = "Sample Genre"
        book.rating = 0
        book.status = false
        book.summary = "Sample Description"
    }
}

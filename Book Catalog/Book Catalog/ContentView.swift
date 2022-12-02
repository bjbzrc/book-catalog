// Created by Brandon Buttlar

import SwiftUI
import CoreData

struct ContentView: View {
    @State var showBookDetailView = false
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Book.entity(), sortDescriptors: [])
    var books: FetchedResults<Book>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .fontWeight(.semibold)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("by \(book.author)")
                                .font(.subheadline)
                                .fontWeight(.light)
                            if book.status {
                                Text("Read")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                            } else {
                                Text("Unread")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                            }
                        }
                        VStack {
                            NavigationLink(destination: BookDetailView(book: book)) { }
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewContext.delete(books[index])
                    }
                    do {
                        try viewContext.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .navigationTitle("Book Catalog")
            .navigationBarItems(trailing: Button(action: {
                showBookDetailView = true
            }, label: {
                Image(systemName: "plus")
                    .imageScale(.large)
            }))
            .sheet(isPresented: $showBookDetailView) {
                NewBookView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

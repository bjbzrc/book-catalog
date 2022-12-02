// Created by Brandon Buttlar

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var title: String
    @NSManaged public var author: String
    @NSManaged public var id: UUID?
    @NSManaged public var summary: String
    @NSManaged public var genre: String
    @NSManaged public var rating: Int16
    @NSManaged public var status: Bool

}

extension Book : Identifiable {

}

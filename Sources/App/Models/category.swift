
import FluentSQLite
import Vapor

final class Category: Codable {
    var id: Int?
   // var idd: Int
    var title: String
    var userId: Int
    var completed: Bool
    
    init(id: Int,userId: Int,title: String,completed: Bool) {
        self.title = title
       // self.idd = id
        self.userId = userId
        self.completed = completed
    }
}

extension Category: SQLiteModel {}
extension Category: Content {}
extension Category: Migration {}

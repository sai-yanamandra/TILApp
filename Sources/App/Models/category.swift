
//import FluentSQLite
import Vapor

final class Category: Codable {
    var id: String
    var timestamp: String
    var lang: String
    var sessionId: String
    
    init(id: String, timestamp: String,lang: String,sessionId: String) {
        self.id = id
        self.timestamp = timestamp
        self.lang = lang
        self.sessionId = sessionId
    }
}

//extension Category: SQLiteModel {}
extension Category: Content {}
//extension Category: Migration {}

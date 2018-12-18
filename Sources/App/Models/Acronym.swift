import FluentSQLite
import Vapor

final class Acronym: Codable {
    
    var id: Int?
    var short: String
    var long: String
    var creatorID: User.ID
    
    init(short: String, long: String, creatorID: UUID) {
        self.short = short
        self.long = long
        self.creatorID = creatorID
    }
}

extension Acronym: SQLiteModel {}
extension Acronym: Content {}
extension Acronym: Migration {}

extension Acronym {
    var creator: Parent<Acronym, User> {
        return parent(\.creatorID)
    }
}



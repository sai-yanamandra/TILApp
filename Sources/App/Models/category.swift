
//import FluentSQLite
import Vapor

struct Status : Codable {
    
    let code : Int
    let errorType: String
    
    enum CodingKeys : String, CodingKey {
        
        case code = "code"
        case errorType = "errorType"
    }
}

struct ClientParameters : Codable {
    
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    
}

struct Context : Codable {
    
    let name: String
    //let parameters: ClientParameters
    let lifespan: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        //case parameters = "parameters"
        case lifespan = "lifespan"
    }
}

struct Metadata: Codable {
    
    let intentId: String
    let webhookUsed: String
    let webhookForSlotFillingUsed: String
    let isFallbackIntent: String
    let intentName: String
    
    enum CodingKeys: String, CodingKey {
        case intentId = "intentId"
        case webhookUsed = "webhookUsed"
        case webhookForSlotFillingUsed = "webhookForSlotFillingUsed"
        case isFallbackIntent = "isFallbackIntent"
        case intentName = "intentName"
    }
}

struct Message : Codable {
    let type: Int
    let speech: String
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case speech = "speech"
    }
}

struct Fulfillment : Codable {
    let speech: String
    let messages: [Message]
    
    enum CodingKeys: String, CodingKey {
        case speech = "speech"
        case messages = "messages"
    }
}

struct Result : Codable {
    
    let source: String
    let resolvedQuery : String
    let action: String
    let actionIncomplete: Bool
    //let parameters: ClientParameters
    let contexts: [Context]
    let metadata: Metadata
    let fulfillment: Fulfillment
    let score: Double
    
    enum CodingKeys : String, CodingKey {
        case source = "source"
        case resolvedQuery = "resolvedQuery"
        case action = "action"
        case actionIncomplete = "actionIncomplete"
        //case parameters = "parameters"
        case contexts = "contexts"
        case metadata = "metadata"
        case fulfillment = "fulfillment"
        case score = "score"
    }
}

final class Category: Codable {
    var id: String
    var timestamp: String
    var lang: String
    var sessionId: String
    var status: Status
    var result: Result
    
    enum CodingKeys : String, CodingKey {
        case status = "status"
        case id = "id"
        case lang = "lang"
        case sessionId = "sessionId"
        case timestamp = "timestamp"
        case result = "result"
    }
    init(id: String, timestamp: String,lang: String,sessionId: String, status: Status, result: Result) {
        self.id = id
        self.timestamp = timestamp
        self.lang = lang
        self.sessionId = sessionId
        self.status = status
        self.result = result
    }
}

//extension Category: SQLiteModel {}
extension Category: Content {}
//extension Category: Migration {}

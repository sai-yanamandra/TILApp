
import Vapor

struct CategoriesController: RouteCollection {
    
    func boot(router: Router) throws {
        let categoryRoutes = router.grouped("api","categories")
       // categoryRoutes.post(use: createHandler)
        //categoryRoutes.get(use: getHandler)
        categoryRoutes.get(Category.parameter, use: getHandler)
        
    }
    
//    func createHandler(_ req: Request) throws -> Future<Category> {
//        return try req.content.decode(Category.self).flatMap(to: Category.self) { category in
//            return category.save(on: req)
//        }
//
//    }
    
//    func getAllHandler(_ req: Request) throws -> Future<[Category]> {
//        return Category.query(on: req).all()
//    }
    
    func getHandler(_ req: Request) throws -> Future<String> {
        //return try req.parameters.next(Category.self)
        
        // Fetch an HTTP Client instance
        let client = try req.make(Client.self)
        
        var headers = HTTPHeaders()
        headers.add(name: "Authorization", value: "Bearer e59a8939c0514bd793d952254c65e7b8")
        
        //let headers = HTTPHeaders("Authorization","Bearer e59a8939c0514bd793d952254c65e7b8")
        
        let queryParam = try req.parameters.next(Category.self)
        print("Query Param: \(queryParam)")
        let query = "https://api.dialogflow.com/v1/query?v=20150910&contexts=shop&lang=en&query=" + queryParam + "&sessionId=12345&timezone=America/New_York"
    
        let response = client.get(query, headers: headers)
        
        // Transforms the `Future<Response>` to `Future<Category>`
        let category =  response.flatMap(to: Category.self) { response in
            return try response.content.decode(Category.self)
        }
        
        return category.map(to: String.self) { category in
            return category.result.fulfillment.speech
        }
    }
}


extension Category: Parameter {
    static func resolveParameter(_ parameter: String, on container: Container) throws -> String {
        return parameter
    }
    
    typealias ResolvedParameter = String
}

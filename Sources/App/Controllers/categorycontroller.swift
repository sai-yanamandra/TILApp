
import Vapor

struct CategoriesController: RouteCollection {
    
    func boot(router: Router) throws {
        let categoryRoutes = router.grouped("api","categories")
       // categoryRoutes.post(use: createHandler)
        //categoryRoutes.get(use: getAllHandler)
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
    
        let response = client.get("https://api.dialogflow.com/v1/query?v=20150910&contexts=shop&lang=en&query=hello&sessionId=12345&timezone=America/New_York", headers: headers)
        
        print ("RESPONSE : \(response)")
        // Send an HTTP Request to example.vapor.codes/json over plaintext HTTP
        // Returns `Future<Response>`
        //let response = client.get("https://jsonplaceholder.typicode.com/todos/4")
        
        //response.map(to: String, <#T##callback: (Response) throws -> T##(Response) throws -> T#>)
        
        return try response.map(to: String.self) { response -> String in
           return try response.content.syncGet(at: "timestamp")
        }
        // Transforms the `Future<Response>` to `Future<ExampleData>`
//        return try response.flatMap(to: Category.self) { response in
//            return try response.content.decode(Category.self["id"])
//        }
        
        // Renders the `ExampleData` into a `View`
        //return try (exampleData)
        
    }
}

struct MyResponse {
    
    var speech: String
}

extension Category: Parameter {}

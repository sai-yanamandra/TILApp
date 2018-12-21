
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
    
    func getHandler(_ req: Request) throws -> Future<Category> {
        //return try req.parameters.next(Category.self)
        
        // Fetch an HTTP Client instance
        let client = try req.make(Client.self)
        
        // Send an HTTP Request to example.vapor.codes/json over plaintext HTTP
        // Returns `Future<Response>`
        let response = client.get("https://jsonplaceholder.typicode.com/todos/4")
        
        // Transforms the `Future<Response>` to `Future<ExampleData>`
        return try response.flatMap(to: Category.self) { response in
            return try response.content.decode(Category.self)
        }
        
        // Renders the `ExampleData` into a `View`
        //return try (exampleData)
        
    }
}



extension Category: Parameter {}

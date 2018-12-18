
import Vapor

struct CategoriesController: RouteCollection {
    
    func boot(router: Router) throws {
        let categoryRoutes = router.grouped("api","categories")
        categoryRoutes.post(use: createHandler)
        categoryRoutes.get(use: getAllHandler)
        categoryRoutes.get(Category.parameter, use: getAllHandler)
        
    }
    
    func createHandler(_ req: Request) throws -> Future<Category> {
        return try req.content.decode(Category.self).flatMap(to: Category.self) { category in
            return category.save(on: req)
        }
        
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Category]> {
        return Category.query(on: req).all()
    }
    
    func getHandler(_ req: Request) throws -> Future<Category> {
        return try req.parameters.next(Category.self)
    }
}

extension Category: Parameter {}

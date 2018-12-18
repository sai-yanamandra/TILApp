import Vapor

struct UsersController: RouteCollection {
    
    func boot(router: Router) throws {
        let userRoutes = router.grouped("api","users")
        userRoutes.post(use: createHandler)
        userRoutes.get(use: getAllHandler)
        userRoutes.get(User.parameter, use: getAllHandler)
        userRoutes.get(User.parameter, "acronyms", use: getAcronymsHandler)

    }
    
    func createHandler(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).flatMap(to: User.self) { user in
            return user.save(on: req)
        }
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func getHandler(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }

    func getAcronymsHandler(_ req: Request) throws -> Future<[Acronym]> {
        return try req.parameters.next(User.self).flatMap(to: [Acronym].self) { user in
             try user.acronyms.query(on: req).all()
        }
    }
    
}

extension User: Parameter {}

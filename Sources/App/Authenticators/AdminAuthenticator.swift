import Vapor
import Fluent

struct AdminAuthenticator: AsyncBasicAuthenticator {
    typealias User = Admin

    func authenticate(
        basic: BasicAuthorization,
        for request: Request
    ) async throws -> Admin? {
        guard let admin = try await Admin.query(on: request.db)
        .filter(\.$username == basic.username)
        .first() else  {
            return nil
        }

        guard try Bcrypt.verify(basic.password, created: admin.passwordHash) else {
            return nil
        }

        return admin
    }
}
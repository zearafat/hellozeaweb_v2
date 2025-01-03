import Vapor
import Fluent

struct CreateAdmin: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("admins")
            .id()
            .field("username", .string, .required)
            .field("password_hash", .string, .required)
            .create()

            // Create a default admin user
            let passwordHash = try Bcrypt.hash("adminadmin")
            let admin = Admin(username: "admin", passwordHash: passwordHash)
            try await admin.save(on: database)
    }

    func revert(on database: Database) async throws {
        try await database.schema("admins").delete()
    }
}
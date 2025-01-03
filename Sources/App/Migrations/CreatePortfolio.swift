import Vapor
import Fluent

struct CreatePortfolio: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("portfolios")
            .id()
            .field("title", .string, .required)
            .field("description", .string)
            .field("image_path", .string, .required)
            .field("created_at", .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("portfolios").delete()
    }
}
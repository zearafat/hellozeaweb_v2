import Vapor
import Fluent

struct CreatePortfolioInput: Content {
    let title: String
    let description: String
}

struct PortfolioController {
    
    // MARK: - Public Routes

    func index(req: Request) async throws -> View {
        let portfolios = try await Portfolio.query(on: req.db)
        .sort(\.$createdAt, .descending)
        .all()

        return try await req.view.render("index", ["portfolios": portfolios])
    }

    // MARK: - Admin Routes

    // Show admin dashboard with all portfolios
    func adminDashboard(req: Request) async throws -> View {
        let portfolios = try await Portfolio.query(on: req.db).all()
        return try await req.view.render("admin/dashboard", ["porfolios": portfolios])
    }
}
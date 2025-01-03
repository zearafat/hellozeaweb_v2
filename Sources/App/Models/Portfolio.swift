import Fluent
import Vapor

final class Portfolio: Model, Content {
    static let schema = "portfolios"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "description")
    var description: String

    @Field(key: "image_path")
    var imagePath: String

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() { }

    init (id: UUID? = nil, title: String, description: String, imagePath: String) {
        self.id = id
        self.title = title
        self.description = description
        self.imagePath = imagePath
    }
}
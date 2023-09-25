import Fluent

struct CreateProfile: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("profiles")
            .id()
            .field("name", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("profiles").delete()
    }
}

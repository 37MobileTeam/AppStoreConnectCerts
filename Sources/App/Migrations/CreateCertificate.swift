import Fluent

struct CreateCertificate: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("certificates")
            .id()
            .field("name", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("certificates").delete()
    }
}

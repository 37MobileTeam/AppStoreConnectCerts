import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    try app.register(collection: AppsController())
    try app.register(collection: CertificateController())
    try app.register(collection: DownloadController())
    try app.register(collection: ProfileController())
    try app.register(collection: UserController())
}

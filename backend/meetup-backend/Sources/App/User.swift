import Vapor
import FluentMySQL

final class User: MySQLModel {
    var id: Int?
    
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

extension User: Content{}

extension User: Migration{}

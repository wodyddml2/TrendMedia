import Foundation

import RealmSwift

class UserShopping: Object {
    @Persisted var detail: String?
    @Persisted var favorite: Bool
    @Persisted var check: Bool
    
    @Persisted(primaryKey: true) var objectID: ObjectId
    
    convenience init(detail: String) {
        self.init()
        self.detail = detail
        self.favorite = false
        self.check = false
    }
}

import UIKit

import RealmSwift

struct UserShoppingRepository {
    let localRealm = try! Realm()
    
    func fetch() -> Results<UserShopping> {
        return localRealm.objects(UserShopping.self)
    }
    
    func fetchSort(sort: String, ascending: Bool) -> Results<UserShopping> {
        localRealm.objects(UserShopping.self).sorted(byKeyPath: sort, ascending: ascending)
    }
    
    func addRealm(item: UserShopping, list: inout Results<UserShopping>) {
        try! localRealm.write{
            localRealm.add(item)
            list = fetch()
        }
    }
    
    func updateFavorite(item: UserShopping, list: inout Results<UserShopping>) {
        try! localRealm.write {
            item.favorite.toggle()
        }
        list = fetch()
    }
    func updateCheck(item: UserShopping, list: inout Results<UserShopping>) {
        try! localRealm.write {
            item.check.toggle()
        }
        list = fetch()
    }
    
    func deleteRealm(item: UserShopping, list: inout Results<UserShopping>) {
        removeImageFromDocument(fileName: "\(item.objectID).jpg")
        try! localRealm.write {
            localRealm.delete(item)
            list = localRealm.objects(UserShopping.self)
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let imageDirectoryURL = documentDirectory.appendingPathComponent("Image")
        let fileURL = imageDirectoryURL.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
}

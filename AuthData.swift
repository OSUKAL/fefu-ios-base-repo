import Foundation

class AuthRegDataManager {
    static let intance = AuthRegDataManager()
    
    private let defaualts = UserDefaults.standard
    
    static let userNameKey = "username"
    static let userPassKey = "userPass"
    static let userPublicKey = "userPubKey"
    
    private init() {}
    
    func saveUser(login: String, password: String, pabKey: String) {
        saveKey(keyValue: login, typeOfKey: AuthRegDataManager.userNameKey)
        saveKey(keyValue: password, typeOfKey: AuthRegDataManager.userPassKey)
        saveKey(keyValue: pabKey, typeOfKey: AuthRegDataManager.userPublicKey)
    }
    
    func saveKey(keyValue: String, typeOfKey: String) {
        defaualts.setValue(keyValue, forKey: typeOfKey)
    }
    
    func getKey(nameOfKey: String) -> String? {
        return defaualts.string(forKey: nameOfKey)
    }
    
    func deleteKey(nameOfKey: String) {
        defaualts.removeObject(forKey: nameOfKey)
    }
}

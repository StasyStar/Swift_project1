import Foundation
import CoreData

protocol FileCacheProtocol {
    func fetchFriends() -> [Friend]
    func addFriends(friends: [Friend])
    func fetchFriendDate() -> Date?
}

final class FileCache: FileCacheProtocol {
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                print(error)
            }
        })
        return persistentContainer
    }()
    
    func save() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func addFriends(friends: [Friend]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "FriendModelCD")
        for friend in friends {
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [friend.id])
            let result = try? persistentContainer.viewContext.fetch(fetchRequest)
            guard result?.first == nil else { continue }
            let friendModel = FriendModelCD(context: persistentContainer.viewContext)
            friendModel.id = Int64(friend.id)
            friendModel.firstName = friend.firstName
            friendModel.lastName = friend.lastName
            friendModel.photo = friend.photo100
            friendModel.online = Int64(friend.online)
        }
        save()
        addFriendDate()
    }
    
    func fetchFriends() -> [Friend] {
        let fetchRequest: NSFetchRequest<FriendModelCD> = FriendModelCD.fetchRequest()
        guard let friends = try? persistentContainer.viewContext.fetch(fetchRequest) else { return [] }
        var newFriends: [Friend] = []
        for friend in friends {
            newFriends.append(Friend(id: Int(friend.id), firstName: friend.firstName, lastName: friend.lastName, photo100: friend.photo ?? "no photo", online: Int(friend.online)))
        }
        return newFriends
    }
    
    func addGroups(groups: [Group]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "GroupModelCD")
        for group in groups {
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [group.id])
            let result = try? persistentContainer.viewContext.fetch(fetchRequest)
            guard result?.first == nil else { continue }
            let groupModel = GroupModelCD(context: persistentContainer.viewContext)
            groupModel.id = Int64(group.id)
            groupModel.name = group.name
            groupModel.photo = group.photo100
            groupModel.members = Int64(group.membersCount)
        }
        save()
        addGroupDate()
    }
    
    func fetchGroups() -> [Group] {
        let fetchRequest: NSFetchRequest<GroupModelCD> = GroupModelCD.fetchRequest()
        guard let groups = try? persistentContainer.viewContext.fetch(fetchRequest) else { return [] }
        var newGroups: [Group] = []
        for group in groups {
            newGroups.append(Group(id: Int(group.id), name: group.name ?? "no name", screenName: group.screenName ?? "no screenName", photo100: group.photo ?? "no photo", membersCount: Int(group.members)))
        }
        return newGroups
    }
    
    func addFriendDate() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "FriendDate")
        let date = FriendDate(context: persistentContainer.viewContext)
        date.date = Date()
        save()
    }
    
    func fetchFriendDate() -> Date? {
        let fetchRequest: NSFetchRequest<FriendDate> = FriendDate.fetchRequest()
        guard let date = try? persistentContainer.viewContext.fetch(fetchRequest) else { return nil }
        return date.first?.date
    }
    
    func addGroupDate() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "GroupDate")
        let date = GroupDate(context: persistentContainer.viewContext)
        date.date = Date()
        save()
    }
    
    func fetchGroupDate() -> Date? {
        let fetchRequest: NSFetchRequest<GroupDate> = GroupDate.fetchRequest()
        guard let date = try? persistentContainer.viewContext.fetch(fetchRequest) else { return nil }
        return date.first?.date
    }
}


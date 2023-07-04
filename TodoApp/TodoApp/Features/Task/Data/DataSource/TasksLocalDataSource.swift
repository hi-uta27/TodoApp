
import Foundation
import RealmSwift

typealias TaskNotificationBlock = NotificationBlock

protocol TasksLocalDataSource: CreateTaskLocalDataSource, ReadTaskLocalDataSource, UpdateTaskLocalDataSource {
    func startObserveRealmNotification(observeRealm: @escaping TaskNotificationBlock)

    func stopObserveRealmNotification()
}


import Foundation
import RealmSwift

typealias TaskNotificationBlock = NotificationBlock

protocol TasksLocalDataSource: CreateTaskLocalDataSource, ReadTaskLocalDataSource, UpdateTaskLocalDataSource, DeleteTaskLocalDataSource {
    func startObserveRealmNotification(observeRealm: @escaping TaskNotificationBlock)
    func stopObserveRealmNotification()
}

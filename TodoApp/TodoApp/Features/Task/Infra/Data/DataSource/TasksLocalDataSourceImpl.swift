//
//  TaskLocalDataSourceImpl.swift
//  TodoApp
//
//  Created by Heligate on 15/06/2023.
//

import Foundation
import QRealmManagerPackage
import RealmSwift

class TasksLocalDataSourceImpl: DatabaseConfigurable, TasksLocalDataSource {
    var realmMemoryType: RealmMemoryType {
        .inStorage
    }
    
    var schemaName: String? {
        "Task"
    }
    
    var schemaVersion: UInt64? {
        0
    }
    
    var objectTypes: [Object.Type]? {
        [RTaskModel.self]
    }
    
    var embeddedObjectTypes: [EmbeddedObject.Type]? {
        [RCategoryEmbbedModel.self]
    }
    
    var migrationBlock: MigrationBlock? {
        nil
    }
    
    var notificationToken: NotificationToken? {
        willSet {
            notificationToken?.invalidate()
        }
    }
    
    func startObserveRealmNotification(observeRealm: @escaping TaskNotificationBlock) {
        guard let realm = realm() else { return }
        notificationToken = realm.observe(observeRealm)
    }
    
    func stopObserveRealmNotification() {
        notificationToken?.invalidate()
    }
    
    deinit {
        stopObserveRealmNotification()
    }
}

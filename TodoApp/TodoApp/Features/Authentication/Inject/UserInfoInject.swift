//
//  UserInfoInject.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation
import Swinject

protocol UserInfoInject {}

extension UserInfoInject {
    static func registerUserInfo(container: Container) {
        registerData(container: container)
        registerUseCase(container: container)
    }

    private static func registerData(container: Container) {
        container.register(UserInfoRemoteDataSource.self) { _ in
            FirebaseAuthentications()
        }
        container.register(UserInfoRepository.self) { r in
            UserInfoRepositoryImpl(dataSource: r.resolve(UserInfoRemoteDataSource.self)!)
        }
    }

    private static func registerUseCase(container: Container) {
        container.register(UserInforUseCase.self) { r in
            UserInfoUseCaseImpl(repository: r.resolve(UserInfoRepository.self)!)
        }
    }
}

extension FirebaseAuthentications: UserInfoRemoteDataSource {}

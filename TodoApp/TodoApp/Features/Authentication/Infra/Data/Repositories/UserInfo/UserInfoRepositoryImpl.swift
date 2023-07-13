//
//  UserInfoRepositoryImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

class UserInfoRepositoryImpl: UserInfoRepository {
    private var dataSource: UserInfoRemoteDataSource

    init(dataSource: UserInfoRemoteDataSource) {
        self.dataSource = dataSource
    }

    func readUserInfor(completed: @escaping (UserEntity?) -> Void) {
        dataSource.readUserInfo { dto in
            completed(dto?.transferToModel())
        }
    }
}
